---
sort: 2
---

# Documentation

beamFoam implements a cell-centred finite volume formulation of geometrically
exact Simo-Reissner beams. The solver supports large three-dimensional
translations and rotations while retaining a one-dimensional beam mesh.

## Repository Structure

The main user-facing components are:

- `applications/solvers/beamFoam`: the beam solver
- `applications/utilities/createBeamMesh`: creates the one-dimensional beam
  mesh from `constant/beamProperties`
- `applications/utilities/setInitialPositionBeam`: translates or rotates a
  beam into its initial reference configuration
- `src/wireBunchingModels`: beam models, cross-sections, boundary conditions
  and momentum contributions
- `tutorials`: ready-to-run example and validation cases

## Case Workflow

A typical `Allrun` script creates the beam mesh and then starts the solver:

```bash
runApplication createBeamMesh
runApplication beamFoam
```

Cases that do not begin in the default straight orientation use
`setInitialPositionBeam` after mesh creation. For example:

```bash
runApplication setInitialPositionBeam \
    -cellZone beam_0 \
    -translate '(0 0 0)' \
    -rotateAngle '((0 -1 0) 90)'
```

```note
`createBeamMesh` assumes that the undeformed reference configuration is a
straight beam aligned with the global x-direction. This is distinct from the
initial configuration used by a simulation, which may have any orientation and
may be curved. `setInitialPositionBeam` applies rigid translations and
rotations; curved initial configurations require the corresponding reference
and initial-configuration fields.
```

The standard OpenFOAM case directories are used:

- `0/`: initial and boundary conditions
- `constant/`: beam definition, material properties and load histories
- `system/`: solution controls, time schemes and function objects

## Defining Beams

The primary configuration file is `constant/beamProperties`. Its `beamModel`
entry selects the solution model, while the `beams` list defines one or more
beams. A beam entry specifies its cross-section, length, number of segments and
material properties. For example:

```c++
beamModel coupledTotalLagNewtonRaphsonBeam;

beams
(
    beam_0
    {
        crossSectionModel rectangle;

        rectangleCrossSectionModelDict
        {
            b 0.2;
            h 0.2;
            nx 1;
            ny 1;
        }

        length      2;
        nSegments   40;
        E           15.293e6;
        G           5.882e6;
        rho         1000;
    }
);
```

The repository includes circular and rectangular cross-section models. The
selected beam model's coefficient dictionary controls nonlinear iteration
settings such as the maximum number of correctors and solution tolerance.

## Primary Fields and Loads

The primary unknowns are:

- `W`: beam displacement
- `Theta`: beam rotation

Boundary conditions in `0/W` and `0/Theta` apply end constraints, forces and
moments. Distributed loads may be supplied through fields such as `q`, while
time-dependent end loads are commonly defined by data files under `constant/`.

Static and dynamic behavior is selected through the case dictionaries. Dynamic
cases can use OpenFOAM time-discretisation schemes such as Euler or Newmark,
configured in `system/fvSchemes`.

## Post-Processing

The point displacement field `pointW` is intended for visualising the deformed
beam in ParaView:

```bash
touch case.foam
paraview case.foam
```

Apply the **Warp By Vector** filter using `pointW`. Many tutorials also provide
function objects and gnuplot scripts for displacement and energy histories.

For the complete formulation, discretisation and validation study, see the
[beamFoam paper](https://doi.org/10.51560/ofj.v5.170).
