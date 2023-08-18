---
sort: 5
---

# About

---

## Why does solids4foam exist?

* Desire to solve fluid-solid interactions in OpenFOAM
* Desire to run solid mechanics cases natively in OpenFOAM
* A modular approach for coupling different solid and fluid procedures
* Research into finite volume methods for solid mechanics

---

## What is the solids4foam implementation philosophy?

* If you can use OpenFOAM, you can use solids4foam
* Support for main OpenFOAM forks
* Easy to install
* Emphasis on code design and style
* Single executable design

---

## A brief history

<!-- markdown-link-check-disable -->
The finite volume solid mechanics procedures implemented in solids4foam can trace their routes to [Demirdzic, Martinovic and Ivankovic (1988)](https://tinyurl.com/demirdzic1988) and the subsequent developments of Demirdzic and co-workers. See the recent review article by [Cardiff and Demirdzic (2021)](https://link.springer.com/article/10.1007/s11831-020-09523-0#citeas) for more details.

The seminal [Weller et al. (1998)](https://aip.scitation.org/doi/abs/10.1063/1.168744) FOAM/OpenFOAM paper demonstrated a simple small-strain linear elasticity solid mechanics solver, closely based on the methods of Demirdzic and co-workers. The commercial predecssor of OpenFOAM, called FOAM, presented a *solid mechanics* section on the [Nabla Ltd website](https://web.archive.org/web/20041217102538/http://www.nabla.co.uk/main/solids.html#solids) (courtesy of the way back machine).

solids4foam builds on and generalises the [Extend Bazaar FSI toolbox](https://tinyurl.com/extendBazaar) and the `solidMechanics` codes from foam-extend.
<!-- markdown-link-check-enable -->

---

## How to cite

If you use solids4foam for a publication, please cite the following references:

> P. Cardiff, A Karac, P. De Jaeger, H. Jasak, J. Nagy, A. Ivanković, Ž. Tuković: An open-source finite volume toolbox for solid mechanics and fluid-solid interaction simulations. 2018, 10.48550/arXiv.1808.10736, available at https://arxiv.org/abs/1808.10736.
>
> Ž. Tuković, A. Karač, P. Cardiff, H. Jasak, A. Ivanković: OpenFOAM finite volume solver for fluid-solid interaction.  Transactions of Famena, 42 (3), pp. 1-31, 2018, 10.21278/TOF.42301.

The corresponding BibTeX entries are

```
@article{Cardiff2018,
  author =       {P. Cardiff and A. Karac and P. De Jaeger and H. Jasak and J. Nagy and A. Ivankovi\'{c} and \v{Z}. Tukovi\'{c}},
  title =        {An open-source finite volume toolbox for solid mechanics and fluid-solid interaction simulations},
  year =         {2018},
  doi =          {10.48550/arXiv.1808.10736},
  note =         {\url{https://arxiv.org/abs/1808.10736}}
}

@article{Tukovic2018,
  author =       {\v{Z}. Tukovi\'{c} and A. Kara\v{c} and P. Cardiff and H. Jasak and A. Ivankovi\'{c}},
  title =        {OpenFOAM finite volume solver for fluid-solid interaction},
  year =         {2018},
  volume =       {42},
  number =       {3},
  pages =        {1-31},
  journal =      {Transactions of FAMENA},
  doi =          {10.21278/TOF.42301}
}
```

In addition, depending on the functionality selected, there may be additional relevant references (the solver output will let you know!).

---

## What's new in solids4foam-v2.0?

See [here](solids4foam-v2-vs-v1.md).

---

## Contributors

solids4foam is primarily developed by researchers at University College Dublin and the University of Zagreb with contributions from researchers across the OpenFOAM community. In particular, Philip Cardiff (Dublin) is the principal toolbox architect, with significant scientific and implementation contributions from Željko Tuković (Zagreb).

A full list of contributors can be found in the [contributors file](./CONTRIBUTORS.md).
