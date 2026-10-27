#!/usr/bin/env bash
#
# Generate the symlinks that publish solids4foam's in-repository READMEs on
# the website, from bin/docs-manifest.txt.
#
# For each manifest entry the script creates the page symlink and, beside it,
# an images/ directory linking every image the page references. Symlinks under
# a managed directory that no longer correspond to a manifest entry are
# removed, so the tree always matches the manifest.
#
# The READMEs link to each other with paths relative to their place in
# solids4foam, which mean nothing at their place on the site. The script
# therefore also writes:
#
#   _data/docs_links.yml  each page's relative links, resolved to the site
#                         page publishing the target or, failing that, to the
#                         target on GitHub. _includes/templates/content.liquid
#                         applies them.
#   _config.yml           a generated block excluding the pages from
#                         jekyll-relative-links, which would otherwise resolve
#                         the links against the site tree first, and wrongly.
#
# Usage:
#   bin/sync-docs.sh          regenerate the symlinks
#   bin/sync-docs.sh --check  report differences and exit non-zero; changes
#                             nothing. Used by CI.

set -euo pipefail

# Sort bytewise, so that the generated files are identical whichever locale
# the script runs under; otherwise a run on a developer's machine reorders
# what CI generated, and the check fails.
export LC_ALL=C

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
manifest="$repo/bin/docs-manifest.txt"
submodule="imported/solids4foam"
links_data="_data/docs_links.yml"
config="_config.yml"
github="https://github.com/solids4foam/solids4foam"
github_raw="https://raw.githubusercontent.com/solids4foam/solids4foam"
github_branch="development"

check_only=false
if [ "${1:-}" = "--check" ]; then
    check_only=true
elif [ $# -gt 0 ]; then
    echo "usage: $(basename "$0") [--check]" >&2
    exit 2
fi

cd "$repo"

if [ ! -f "$manifest" ]; then
    echo "error: $manifest not found" >&2
    exit 1
fi

if [ ! -e "$submodule/README.md" ]; then
    echo "error: $submodule is not checked out." >&2
    echo "       run: git submodule update --init" >&2
    exit 1
fi

problems=0

note() {
    if $check_only; then
        echo "$1"
        problems=$((problems + 1))
    fi
}

# Emit the relative path from the directory of $1 to the file $2, both given
# relative to the repository root.
relative_to() {
    local from_dir="${1%/*}" to="$2" up=""
    if [ "$from_dir" = "$1" ]; then
        from_dir="."
    fi
    local IFS=/
    # shellcheck disable=SC2086
    set -- $from_dir
    for _ in "$@"; do
        [ "$_" = "." ] || up="../$up"
    done
    printf '%s%s\n' "$up" "$to"
}

# Create, or check, one symlink: $1 is the link path, $2 its target, both
# relative to the repository root.
link() {
    local link_path="$1" target="$2" rel
    rel="$(relative_to "$link_path" "$target")"

    wanted["$link_path"]=1

    if [ -L "$link_path" ] && [ "$(readlink "$link_path")" = "$rel" ]; then
        if [ ! -e "$link_path" ]; then
            note "dangling: $link_path -> $rel"
        fi
        return
    fi

    if [ -e "$link_path" ] && [ ! -L "$link_path" ]; then
        echo "error: $link_path exists and is not a symlink; refusing to" \
             "replace it" >&2
        exit 1
    fi

    if [ ! -e "$target" ]; then
        echo "error: $link_path would point at $target, which does not" \
             "exist" >&2
        exit 1
    fi

    note "missing or wrong: $link_path -> $rel"
    if ! $check_only; then
        mkdir -p "${link_path%/*}"
        ln -sfn "$rel" "$link_path"
    fi
}

declare -A wanted=()
declare -A managed_dirs=()

pages=()
page_sources=()
# The site page publishing each source file; the first entry wins when a
# README is published twice, as the featured tutorials are.
declare -A published=()

while read -r site_path source_path; do
    case "$site_path" in ''|'#'*) continue ;; esac

    target="$submodule/$source_path"
    if [ ! -f "$target" ]; then
        echo "error: $manifest lists $source_path, which does not exist in" \
             "$submodule" >&2
        exit 1
    fi

    link "$site_path" "$target"

    pages+=("$site_path")
    page_sources+=("$source_path")
    [ -n "${published[$source_path]:-}" ] || published["$source_path"]="$site_path"

    page_dir="${site_path%/*}"
    source_dir="${source_path%/*}"
    managed_dirs["$page_dir"]=1

    # Link every image the page references. All references in solids4foam are
    # of the form ](images/foo.png) or ](./images/foo.png).
    while read -r image; do
        [ -n "$image" ] || continue
        image_target="$submodule/$source_dir/images/$image"
        if [ ! -f "$image_target" ]; then
            echo "error: $site_path references images/$image, which does" \
                 "not exist in $submodule/$source_dir" >&2
            exit 1
        fi
        link "$page_dir/images/$image" "$image_target"
    done < <(
        grep -oE '\]\(\.?/?images/[^)]+\)' "$target" 2>/dev/null |
            sed -E 's|.*/||; s|\)$||' | sort -u
    )
done < "$manifest"

# Remove symlinks under managed directories that the manifest no longer wants.
for dir in "${!managed_dirs[@]}"; do
    while read -r existing; do
        [ -n "$existing" ] || continue
        if [ -z "${wanted[$existing]:-}" ]; then
            note "stale: $existing"
            $check_only || rm "$existing"
        fi
    done < <(find "$dir" -maxdepth 2 -type l 2>/dev/null)
done

# Print the path $1 with "." and ".." segments removed. Fails if it climbs
# above the root.
normalise() {
    local IFS=/ segment
    local -a out=()
    # shellcheck disable=SC2086
    set -- $1
    for segment in "$@"; do
        case "$segment" in
            ''|.) ;;
            ..)
                [ ${#out[@]} -gt 0 ] || return 1
                unset 'out[${#out[@]}-1]'
                ;;
            *) out+=("$segment") ;;
        esac
    done
    printf '%s\n' "${out[*]}"
}

# Print the URL, from the site root, of the page at site path $1.
page_url() {
    case "$1" in
        README.md)   echo "/" ;;
        */README.md) echo "/${1%README.md}" ;;
        *)           echo "/${1%.md}.html" ;;
    esac
}

# Quote $1 as a single-quoted YAML scalar.
yaml_quote() {
    printf "'%s'" "${1//\'/\'\'}"
}

# Write the link table for every page to stdout.
generate_links_data() {
    echo "# Generated by bin/sync-docs.sh from bin/docs-manifest.txt; do not edit."
    echo "#"
    echo "# For each page published from solids4foam, its links relative to the"
    echo "# README's place there: 'from' is the link as written; 'page' is the site"
    echo "# page publishing its target, or else 'url' is the target on GitHub, and"
    echo "# 'src' the raw file for an image."
    local i site_path source_dir link path fragment resolved target_page
    local header
    for i in "${!pages[@]}"; do
        site_path="${pages[$i]}"
        source_dir="${page_sources[$i]%/*}"
        header=false
        while read -r link; do
            [ -n "$link" ] || continue
            path="${link%%#*}"
            fragment=""
            [ "$path" = "$link" ] || fragment="#${link#*#}"

            if ! resolved="$(normalise "$source_dir/$path")"; then
                echo "warning: $site_path links to $link, outside" \
                     "$submodule" >&2
                continue
            fi

            if ! $header; then
                echo
                echo "$site_path:"
                header=true
            fi
            echo "  - from: $(yaml_quote "$link")"

            target_page="${published[$resolved]:-${published[$resolved/README.md]:-}}"
            if [ -n "$target_page" ]; then
                echo "    page: $(yaml_quote "$(page_url "$target_page")$fragment")"
                continue
            fi

            if [ -d "$submodule/$resolved" ]; then
                echo "    url: $(yaml_quote "$github/tree/$github_branch/$resolved$fragment")"
                continue
            fi
            if [ ! -e "$submodule/$resolved" ]; then
                echo "warning: $site_path links to $link, which does not" \
                     "exist in $submodule" >&2
            fi
            echo "    url: $(yaml_quote "$github/blob/$github_branch/$resolved$fragment")"
            echo "    src: $(yaml_quote "$github_raw/$github_branch/$resolved")"
        done < <(
            # Inline links and images whose target is relative, except the
            # images/ beside the page, which are linked above.
            grep -oE '\]\([^)[:space:]]+' "$submodule/${page_sources[$i]}" |
                sed 's/^](//' |
                grep -vE '^([a-z]+:|#|<|/|\.?/?images/)' |
                grep -vE "[&\"']" |
                sort -u
        )
    done
}

begin_marker="# BEGIN generated by bin/sync-docs.sh; do not edit."
end_marker="# END generated by bin/sync-docs.sh"

# Write $config to stdout, with the generated block replaced, or appended.
generate_config() {
    local block
    block="$(
        echo "$begin_marker"
        echo "# The pages published from solids4foam: their relative links are"
        echo "# rewritten from $links_data instead."
        echo "relative_links:"
        echo "  exclude:"
        printf '    - %s\n' "${pages[@]}"
        echo "$end_marker"
    )"
    if grep -qxF "$begin_marker" "$config"; then
        BLOCK="$block" awk -v begin="$begin_marker" -v end="$end_marker" '
            $0 == begin { print ENVIRON["BLOCK"]; skip = 1; next }
            $0 == end   { skip = 0; next }
            !skip
        ' "$config"
    else
        cat "$config"
        echo
        echo "$block"
    fi
}

# Create, or check, the generated file $1 from the output of $2.
generated() {
    local file="$1" generator="$2" tmp
    tmp="$(mktemp)"
    "$generator" > "$tmp"
    if [ -f "$file" ] && cmp -s "$tmp" "$file"; then
        rm "$tmp"
        return
    fi
    note "out of date: $file"
    if ! $check_only; then
        mkdir -p "$(dirname "$file")"
        cat "$tmp" > "$file"
    fi
    rm "$tmp"
}

generated "$links_data" generate_links_data
generated "$config" generate_config

if $check_only; then
    if [ "$problems" -gt 0 ]; then
        echo
        echo "$problems difference(s); run bin/sync-docs.sh" >&2
        exit 1
    fi
    echo "documentation symlinks are in sync with bin/docs-manifest.txt"
fi
