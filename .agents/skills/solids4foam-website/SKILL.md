# solids4foam Website Skill

Use this skill when working in the `website.solids4foam.github.io` repository,
which publishes the solids4foam website at `www.solids4foam.com`.

## Goal

Make safe edits to website content, navigation, and theme assets without
breaking the Jekyll build, Markdown CI, or published URLs.

## Repository Map

- `README.md` is the homepage.
- Primary site sections live in `about/`, `installation/`, `tutorials/`,
  `documentation/`, and `support/`.
- Theme and layout code live in `_includes/`, `_layouts/`, `_sass/`, and
  `assets/`.
- `assets/js/theme.js` and `_sass/theme.scss` are the source entry points for
  the compiled theme assets.
- `imported/solids4foam` is a Git submodule checkout of the upstream toolbox.
  Treat it as imported/vendor content unless the task is explicitly about
  updating that submodule.

## Site Mechanics

- The site is Jekyll-based and uses `readme_index`, so many directory
  `README.md` files are rendered as section landing pages.
- Section landing pages usually keep YAML frontmatter such as `sort: N` and use
  `{% include list.liquid all=true %}` to render child-page navigation.
- Internal navigation depends on directory structure, relative links, and
  preserved frontmatter. Avoid changing slugs or moving pages unless the task
  requires it.
- `_config.yml` excludes `imported/`, `node_modules/`, and build metadata from
  the site build. Do not assume content under `imported/` is published.

## Content Rules

- Match the current tone: technical, direct, and practical.
- Prefer small, targeted edits over broad rewrites.
- Keep installation and tutorial commands exact and runnable.
- Use relative links for internal pages and local images.
- Preserve nearby formatting patterns for frontmatter, headings, code fences,
  tables, and callouts.
- For citation-heavy pages, keep references precise and avoid promotional copy.

## Asset Rules

- Prefer editing source files, not generated outputs.
- If theme JS or SCSS changes, rebuild `assets/js/theme.min.js` and
  `assets/css/theme.min.css` through the existing build commands rather than
  hand-editing minified files.
- Keep generated diffs tight; review them carefully so real changes are not
  buried in build noise.

## CI And Validation

This repo currently checks Markdown rather than running a full deployment build
in GitHub Actions.

- Markdown lint runs on `README.md`, `about/**/*.md`, `documentation/**/*.md`,
  `installation/**/*.md`, `support/**/*.md`, `tutorials/**/*.md`, and
  `imported/**/*.md`.
- Link checking runs with `.markdown_linkcheck_config.json`, which includes a
  small ignore list for unstable external URLs.

Use these commands when validating work:

- `npm run format` to apply/check Prettier formatting.
- `make dist` or `npm run build` after changing theme JS/SCSS assets.
- `bundle exec jekyll build --safe --profile` or `make build` for a full local
  site build when content, layouts, or includes change.

## Common Work

### Updating content pages

1. Edit the page in the most specific section directory.
2. Preserve existing frontmatter and page ordering.
3. Check nearby section indexes if the navigation should expose the new page.
4. Validate formatting and, when relevant, run a Jekyll build.

### Updating landing pages

1. Keep the page concise; landing pages usually summarize and link onward.
2. Preserve `list.liquid` includes unless the change intentionally alters child
   page navigation.
3. Recheck local links and section ordering.

### Updating imported upstream material

1. Treat `imported/solids4foam` changes as a deliberate submodule update.
2. Keep submodule changes separate from normal site edits unless the task
   explicitly combines them.
3. Do not edit imported upstream files casually while working on website-only
   tasks.

## What Good Changes Look Like

- Published pages stay in the same place unless intentionally moved.
- Tutorial and installation instructions remain executable.
- Navigation still works from homepage to nested sections.
- Markdown CI remains clean.
- The imported submodule is untouched unless the task explicitly requires it.
