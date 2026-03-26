# solids4foam Website Skill

Use this skill when working on the solids4foam website repository, which is a
Jekyll site published on GitHub Pages at `www.solids4foam.com`.

## Goal

Make safe, accurate edits to the website content, layout, and build assets
without breaking navigation, documentation links, or the site build.

## Repository Shape

- `README.md` is the homepage and project overview.
- Section landing pages live in `about/`, `installation/`, `tutorials/`,
  `documentation/`, and `support/`.
- `assets/`, `_includes/`, `_layouts/`, and `_sass/` contain the theme and site
  implementation.
- `imported/solids4foam` is an upstream submodule checkout. Treat it as vendor
  content unless the task explicitly says to update the imported upstream
  pointer.

## How This Site Works

- The site uses Jekyll with the `readme_index` plugin so many directory
  `README.md` files become section index pages.
- Section index pages typically have frontmatter like `sort: N` and then include
  `list.liquid` to render child pages.
- Markdown pages are the primary content format. Keep frontmatter intact and
  preserve existing page ordering and URLs.
- The theme is custom and partly vendored from npm packages. Build outputs and
  copied theme assets should be refreshed through the existing scripts rather
  than edited by hand when possible.

## Editing Rules

- Prefer small, targeted changes over broad rewrites.
- Preserve the existing tone: technical, concise, and practical.
- Keep installation and tutorial instructions exact and runnable.
- Use relative links for internal pages and images.
- Do not change published paths or section structure unless the task requires
  it.
- Do not edit generated or vendored assets unless you are intentionally
  refreshing them.
- Do not touch `imported/solids4foam` unless the work is specifically about
  syncing the upstream submodule.

## Content Conventions

- Landing pages usually summarize and link out rather than repeat full details.
- Tutorial pages should explain prerequisites, commands, and expected outcomes in
  a way a user can follow directly.
- Documentation pages should prefer stable terminology and avoid speculative or
  marketing language.
- When adding references, keep citations precise and avoid bloated prose.
- Keep markdown tables, code fences, and callouts consistent with nearby files.

## Verification

Use the existing project commands when validating changes:

- `npm run format` for formatting checks and fixes.
- `bundle exec jekyll build --safe --profile` or `make build` for a full site
  build.
- `make dist` when theme CSS/JS assets need to be rebuilt.

If you change links or citation-heavy pages, also verify that the markdown link
checker configuration still makes sense for the new URLs.

## Common Tasks

### Adding or updating a documentation page

1. Find the right section directory.
2. Add or update the page frontmatter and body.
3. Ensure any section index pages still include the list helper if needed.
4. Run the site build and check for broken links or navigation regressions.

### Updating theme or asset files

1. Prefer the repository scripts over manual editing.
2. Refresh the generated files only when necessary.
3. Review the diff carefully so generated noise does not hide real content
   changes.

### Syncing upstream solids4foam content

1. Update the submodule intentionally.
2. Review the resulting site-facing diffs separately from the submodule change.
3. Do not mix unrelated website edits into the same upstream sync unless needed.

## What Good Changes Look Like

- Accurate, concise documentation.
- Navigation that still works from the homepage down into nested content.
- Minimal churn in generated files.
- No accidental edits to vendored content or the imported upstream checkout.

