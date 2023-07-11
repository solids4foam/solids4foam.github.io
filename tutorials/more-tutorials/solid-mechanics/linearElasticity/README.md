---
sort: 1
---

# Tutorials for Linear Elasticity

The tutorials described in this section are located in `tutorials/solid/linearElasticity` directory. Linear (linearised) elasticity is used to represent the mechanical behavior of materials undergoing *small* reversible deformations; for example, in the stress analysis of a metallic engineering component. The assumption of linear elasticity implies that a *small deformation* (linear geometry) modelling approach is employed. Linear elastic material behaviour is specified in the ``constant/mechanicalProperties` dictionary as, for example
```
    steel
    {
        type            linearElastic;
        rho             rho [1 -3 0 0 0 0 0] 7800;
        E               E [1 -1 -2 0 0 0 0] 210e+09;
        nu              nu [0 0 0 0 0 0 0] 0.3;
    }
```

Several solid model are available for analysing linear elastic materials in solids4foam, as specified in the `constant/solidProperties` dictionary. For example, a segregated cell-centred finite volume solid model:
```
solidModel     linearGeometryTotalDisplacement;

linearGeometryTotalDisplacementCoeffs
{
    // Optional parameters for this solid model
}
```

---

# Tutorial Guides

{% include list.liquid all=true %}
