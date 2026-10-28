---
sort: 1
---

# Project team

solids4foam is primarily developed by researchers at University College Dublin
and the University of Zagreb with contributions from researchers across the
OpenFOAM community.

## Principal Developers

- Philip Cardiff
- Ivan Batistić
- Željko Tuković

## Contributors

The wider solids4foam community contributes through code, reviews, issue
reports, testing, documentation, tutorials, and discussions; see also the
[GitHub contributors graph](https://github.com/solids4foam/solids4foam/graphs/contributors).
If you would like to join them, see [how to contribute](../contributing/README.md).

{% comment %}
The list below is CONTRIBUTORS.md from the solids4foam repository, which
bin/sync-docs.sh publishes as _snippets/contributors.md. Its heading is
demoted so that it sits under this section.
{% endcomment %}
{% assign contributors = site.snippets | where: "path", "_snippets/contributors.md" | first %}
{{ contributors.content | markdownify | replace: "<h1 ", "<h3 " | replace: "</h1>", "</h3>" }}
