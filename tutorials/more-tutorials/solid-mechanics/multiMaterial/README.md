---
sort: 4
---

# Tutorials for Multiple Materials

The tutorials described in this section are located in `tutorials/solid/multiMaterial` directory. These tutorials demonstrate how to use multiple materials in a `solids4foam` analysis. Mulitple materials can be defined in `constant/mechanicalProperties` as, for example,
```
    steel
    {
        type            linearElastic;
        rho             rho [1 -3 0 0 0 0 0] 7800;
        E               E [1 -1 -2 0 0 0 0] 210e+09;
        nu              nu [0 0 0 0 0 0 0] 0.3;
    }
    rubber
    {
        type            linearElastic;
        rho             rho [1 -3 0 0 0 0 0] 2000;
        E               E [1 -1 -2 0 0 0 0] 100e+06;
        nu              nu [0 0 0 0 0 0 0] 0.4;
    }
```
where the `solids4Foam` solver expects to find a `cellZone` defined in the mesh for each material. It is assumed that the `cellZones` have the same names as the materials, e.g. `steel`, `rubber`.

---

# Tutorial Guides

{% include list.liquid all=true %}
