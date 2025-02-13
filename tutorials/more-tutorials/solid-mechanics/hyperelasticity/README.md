---
sort: 3
---

# Tutorials for Hyperelastic Materials

## Overview

The tutorials described in this section are located in
`tutorials/solid/hyperelasticity` folder. Hyperelastic laws are typically used
to represent the mechanical behavior of rubbery materials and also soft tissues,
such as arterial tissue. The motion of this type of solids is normally in the
range of _large deformations_, in which the small-strain theory cannot be
applied. In this situation, different mathemathical formulations of the
governing equations of the motion exist known as _total_ or _updated Lagrangian_
formulations. These are implemented under the `solidModel` class in `solids4foam`
and will be exemplified in the next tutorials.

Only three representatives examples are described, but others are also
available. The choice for different `solidModel`s to use must be set in the
dictionary `constant/solidProperties` for a solid-only analysis, while the
mechanical properties of the material used are set in the dictionary
`constant/mechanicalProperties`.

---

## Tutorial Guides

{% include list.liquid all=true %}
