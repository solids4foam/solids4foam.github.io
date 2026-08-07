---
sort: 1
---

# Overview

---

## Ethos

The solids4foam project aims is to develop an OpenFOAM toolbox for solid
mechanics and fluid-solid interactions that is:

- intuitive to **use** for new users
- easy to **understand** at the case and code level
- straightforward to **maintain**
- uncomplicated to **extend**

In addition, the toolbox aims to be compatible with all major OpenFOAM forks.

---

## How the Pieces Fit Together

There is one solver, [`solids4Foam`](applications/solids4Foam.md), and it
contains no details of the physics or the discretisation. Instead it creates a
run-time selectable `physicsModel` and advances it in time. The `type` entry in
`constant/physicsProperties` chooses one of three families:

| `type`                  | Dictionary                 | Base class            | Documentation                                              |
| ----------------------- | -------------------------- | --------------------- | ---------------------------------------------------------- |
| `solid`                 | `constant/solidProperties` | `solidModel`          | [Solid models](solid-models/README.md)                     |
| `fluid`                 | `constant/fluidProperties` | `fluidModel`          | [Fluid models](fluid-models/README.md)                     |
| `fluidSolidInteraction` | `constant/fsiProperties`   | `fluidSolidInterface` | [Fluid-solid interfaces](fluid-solid-interfaces/README.md) |

A **solid model** solves the momentum equation in a solid domain. The available
models differ in whether the geometry is linear or nonlinear, whether a total
or updated Lagrangian formulation is used, whether the discretisation is
cell-centred or vertex-centred, and whether the solution algorithm is
segregated, coupled or explicit.

A **fluid model** solves the flow equations; most are ports of a standard
OpenFOAM solver into class form, for example `pimpleFluid` from `pimpleDyMFoam`
and `interFluid` from `interDyMFoam`.

A **fluid-solid interface** owns one fluid model and one solid model and
implements the partitioned coupling algorithm between them, for example
`fixedRelaxationCouplingInterface`, `AitkenCouplingInterface`,
`IQNILSCouplingInterface`, `weakCouplingInterface` and
`oneWayCouplingInterface`. The differences between these are explored in
[tutorial 4](../tutorials/tutorial4.md).

The constitutive behaviour of a solid is kept separate from the solid model
that uses it, so the two can be varied independently:
`constant/mechanicalProperties` selects one or more `mechanicalLaw` objects,
which return the stress for a given deformation, and
`constant/thermalProperties` does the same for thermal behaviour.

```Note
Standard solvers in OpenFOAM can differ significantly between OpenFOAM forks.
solids4foam aims to include the fork-specific solver versions, e.g. when using
OpenFOAM-v2012, `pimpleFluid` is a port of `pimpleDyMFoam` from OpenFOAM-v2012.
```

Run-time post-processing is provided by the
[function objects](function-objects/README.md), and the internal structure of the
library is described under [under the hood](under-the-hood/README.md).

---

## Toolbox Structure

The solids4foam toolbox follows the OpenFOAM structure:

```bash
solids4foam
├── Allwclean
├── Allwmake
├── README.md
├── ThirdParty
├── ...
├── applications
│   ├── scripts
│   ├── solvers
│   │   └── solids4Foam
│   ├── test
│   └── utilities
├── optionalFixes
├── src
│   ├── RBFMeshMotionSolver
│   ├── abaqusUMATs
│   ├── blockCoupledSolids4FoamTools
│   ├── higherOrderHelpers
│   └── solids4FoamModels
└── tutorials
    ├── Alltest
    ├── fluidSolidInteraction
    ├── fluids
    └── solids
```

- `Allwmake` and `Allwclean` compile and clean the toolbox:

  ```bash
  > ./Allwmake
  > ./Allwclean
  ```

- `ThirdParty`: solids4foam optionally uses some third-party code (e.g. Eigen,
  PETSc): for more details, see the
  [installation guide](../installation/README.md).
- `applications`: contains the `solids4Foam` solver, a small number of helper
  utilities, and the Bash functions used by the tutorials; see
  [applications](applications/README.md).
- `src`: contains the libraries used by the `solids4Foam` solver, of which
  `solids4FoamModels` is the main one, defining the fluid, solid and
  fluid-solid interaction algorithms; see [under the hood](under-the-hood/README.md).
- `tutorials`: contains example cases for fluid, solid and fluid-solid
  interaction analyses; many of these are described in the
  [tutorials guide](../tutorials/README.md).

The `solids4FoamModels` library is organised by the components above:

```bash
solids4foam
└── src
    └── solids4FoamModels
        ├── dynamicFvMesh
        ├── fluidModels
        ├── fluidSolidInterfaces
        ├── functionObjects
        ├── materialModels
        ├── numerics
        ├── physicsModel
        └── solidModels
```

---

## A Note on Coding Style

solids4foam aims to follow the
[OpenFOAM Coding Style Guide closely](https://openfoam.org/dev/coding-style-guide).
When a consistent style is not followed, reading code generated by others
becomes tedious, painstaking and even impossible. Coding style is a crucial
feature of software that is easy to read, understand, maintain and extend. For
example:

### Bad

```c++
Info <<“This is not good”
<< endl;

( a+b ) * ( c&d ) / (e&&f)

if(myName == “Philip”){
success = true;
}

…
```

### Good

```c++
Info<< “That’s better”
    << endl;

(a + b)*(c & d)/(e && f)

if (myName == “Philip”)
{
    success = true;
}

…
```

Contributions are welcome; please see the
[contributing guide](under-the-hood/contributing.md).
