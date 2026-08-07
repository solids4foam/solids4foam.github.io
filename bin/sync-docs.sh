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
# Usage:
#   bin/sync-docs.sh          regenerate the symlinks
#   bin/sync-docs.sh --check  report differences and exit non-zero; changes
#                             nothing. Used by CI.

set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
manifest="$repo/bin/docs-manifest.txt"
submodule="imported/solids4foam"

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

while read -r site_path source_path; do
    case "$site_path" in ''|'#'*) continue ;; esac

    target="$submodule/$source_path"
    if [ ! -f "$target" ]; then
        echo "error: $manifest lists $source_path, which does not exist in" \
             "$submodule" >&2
        exit 1
    fi

    link "$site_path" "$target"

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

if $check_only; then
    if [ "$problems" -gt 0 ]; then
        echo
        echo "$problems difference(s); run bin/sync-docs.sh" >&2
        exit 1
    fi
    echo "documentation symlinks are in sync with bin/docs-manifest.txt"
fi
