---
sort: 6
---

# About

---

## Why does solids4foam exist?

- Desire to solve fluid-solid interactions in OpenFOAM
- Desire to run solid mechanics cases natively in OpenFOAM
- A modular approach for coupling different solid and fluid procedures
- Research into finite volume methods for solid mechanics

---

## What is the solids4foam implementation philosophy?

- If you can use OpenFOAM, you can use solids4foam
- Support for main OpenFOAM forks
- Easy to install
- Emphasis on code design and style
- Single executable design

---

## A brief history

<!-- markdown-link-check-disable -->

The finite volume solid mechanics procedures implemented in solids4foam can
trace their routes to
[Demirdzic, Martinovic and Ivankovic (1988)](https://tinyurl.com/demirdzic1988)
and the subsequent developments of Demirdzic and co-workers. See the recent
review article by
[Cardiff and Demirdzic (2021)](https://link.springer.com/article/10.1007/s11831-020-09523-0#citeas)
for more details.

The seminal
[Weller et al. (1998)](https://aip.scitation.org/doi/abs/10.1063/1.168744)
FOAM/OpenFOAM paper demonstrated a simple small-strain linear elasticity solid
mechanics solver, closely based on the methods of Demirdzic and co-workers. The
commercial predecssor of OpenFOAM, called FOAM, presented a _solid mechanics_
section on the
[Nabla Ltd website](https://web.archive.org/web/20041217102538/http://www.nabla.co.uk/main/solids.html#solids)
(courtesy of the way back machine).

solids4foam builds on and generalises the
[Extend Bazaar FSI toolbox](https://tinyurl.com/extendBazaar) and the
`solidMechanics` codes from foam-extend.

<!-- markdown-link-check-enable -->

---

## Further information

{% include list.liquid all=true %}
