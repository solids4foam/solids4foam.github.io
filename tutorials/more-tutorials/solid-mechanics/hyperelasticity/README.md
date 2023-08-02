---
sort: 3
---

# Tutorials for Hyperelastic Materials

The tutorials described in this section are located in
`tutorials/solid/hyperelasticity` folder. Hyperelastic laws are typically used
to represent the mechanical behavior of rubbery materials and also soft
tissues, such as arterial tissue. The motion of this type of solids is normally
in the range of *large deformations*, in which the small-strain theory cannot
be applied. In this situation, different mathemathical formulations of the
governing equations of the motion exist known as *total* or *updated
Lagrangian* formulations (see [the documention](#nonlinear-geometry-approach)).
These are implemented under the
[`solidModel`](#solid-models-available-in-solids4foam) class in `solids4foam`
and will be exemplified in the next tutorials.

Only three representatives examples are described, but others are also
available. The choice for different `solidModel`s to use must be set in the
dictionary `constant/solidProperties` for a solid-only analysis, while the
mechanical properties of the material used are set in the dictionary
`constant/mechanicalProperties`.

---

# Tutorial Guides

{% include list.liquid all=true %}
