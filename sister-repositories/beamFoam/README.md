---
sort: 1
---

# beamFoam

[beamFoam](https://github.com/solids4foam/beamFoam) is a cell-centred finite
volume solver for nonlinear geometrically exact Simo-Reissner beams in
OpenFOAM®. It models slender structures undergoing large three-dimensional
deformations and rotations, including tension, bending, shear and torsion.

Although the beam model is one-dimensional, it resolves three-dimensional
displacements and rotations. This makes beamFoam suitable for efficiently
representing slender structures and for developing coupled simulations within
the OpenFOAM environment.

## Getting Started

Start with the [installation guide](installation/README.md), then review the
[documentation](documentation/README.md) and run the
[tutorials](tutorials/README.md).

For source code, bug reports and development activity, visit the
[beamFoam GitHub repository](https://github.com/solids4foam/beamFoam).

## Publication

The formulation, implementation and three principal benchmark cases are
described in:

> S. Bali, A. Taran, Ž. Tuković, V. Pakrashi and P. Cardiff. beamFoam: A
> Cell-Centred Finite Volume Solver for Nonlinear Geometrically-Exact Beams in
> OpenFOAM. OpenFOAM® Journal, 5, 180-210, 2025.
> [doi:10.51560/ofj.v5.170](https://doi.org/10.51560/ofj.v5.170).

{% include list.liquid all=true %}
