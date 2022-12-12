---
sort: 1
---

# Tutorials for Hyperelastic Solid Materials

The tutorials described in this section are located in
`tutorials/solid/hyperelasticity` folder (see structure below) and have the
following aims:

- Exemplify how to perform solid analyses in solids4foam with hyperelastic
  materials;
- Demonstrate the use of the updated and total Lagrangian formulation for
  large-strains.

```bash
tutorials
├── …
├── fluidSolidInteraction
│   └── …
├── fluids
│   └── …
└── solids
    ├── elastoplasticity
    ├── fracture
    ├── **hyperelasticity**
    ├── linearElasticity
    ├── multiMaterial
    ├── poroelasticity
    ├── thermoelasticity
    └── viscoelasticity
```

We will cover only three representatives examples, but other are also
available. The choice for different `solidModel`s to use must be set in the
dictionary `constant/solidProperties` for a solid-only analysis, while the
mechanical properties of the material used are set in the dictionary
`constant/mechanicalProperties`.

---

# Tutorial guides

{% include list.liquid all=true %}
