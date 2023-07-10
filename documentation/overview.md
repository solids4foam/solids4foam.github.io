---
sort: 1
---

# Overview

---

## Ethos

The solids4foam project aims is to develop an OpenFOAM toolbox for solid mechanics and fluid-solid interactions that is:
- intuitive to **use** for new users
- easy to **understand** at the case and code level
- straightforward to **maintain**
- uncomplicated to **extend**

In addition, the toolbox aims to be compatible with all major OpenFOAM forks.

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
│   ├── ...
│   ├── scripts
│   ├── solvers
│   │   └── solids4Foam
│   └── utilities
├── optionalFixes
├── src
│   ├── ...
│   ├── RBFMeshMotionSolver
│   ├── abaqusUMATs
│   ├── blockCoupledSolids4FoamTools
│   └── solids4FoamModels
└── tutorials
    ├── Alltest
    ├── ...
    ├── fluidSolidInteraction
    ├── fluids
    └── solids
```
- Scripts to compile and clean the toolbox:
    ```bash
    > ./Allwmake
    > ./Allwclean
    ```

    The README file briefly describes the toolbox.

    *solids4foam* 
- `ThirdParty`: solids4foam optionally uses some third-party code (e.g. Eigen, PETSc): for more details, see the (installation guide)[https://solids4foam.github.io/installation/].
- `applications`:  contains the `solids4Foam` solver and a small number of helper utilities.

- `src`: contains libraries used by the `solids4Foam` solver, such as  `solids4FoamModels` which defines fluid, solid and fluidSolidInteraction algorithms.
- `tutorial`: contains example cases for fluid, solid and fluidSolidInteraction analyses; some of these example cases are described in the (tutorials guide)[https://solids4foam.github.io/tutorials/].

---

## `solids4Foam` Solver

The solids4Foam solver code is available at:

> solids4foam/applications/solvers/solids4Foam/solids4Foam.C

```
int main(int argc, char *argv[])
{
#   include "setRootCase.H"
#   include "createTime.H"
#   include "solids4FoamWriteHeader.H"

    // Create the general physics class
    autoPtr<physicsModel> physics = physicsModel::New(runTime);

    while (runTime.run())
    {
        // Update deltaT, if desired, before moving to the next step
        physics().setDeltaT(runTime);

        runTime++;

        if (physics().printInfo())
        {
            Info<< "Time = " << runTime.timeName() << nl << endl;
        }

        // Solve the mathematical model
        physics().evolve();

        // Let the physics model know the end of the time-step has been reached
        physics().updateTotalFields();

        if (runTime.outputTime())
        {
            physics().writeFields(runTime);
        }

        if (physics().printInfo())
        {
            Info<< "ExecutionTime = " << runTime.elapsedCpuTime() << " s"
                << "  ClockTime = " << runTime.elapsedClockTime() << " s"
                << nl << endl;
        }
    }

    physics().end();

    Info<< nl << "End" << nl << endl;

    return(0);
}
```

As seen above, the `solid4Foam` solver contains no details about the physics and discretisation. Instead, a run-time selectable `physicsModel` object is created to encapsulate the specifics. Virtual functions, such as `evolve()`, are used to tell the physics model object to solve its governing equation for the current time step.

---

#### `physicsModel` Class

The `physicsModel` is an abstract base class with three derived classes:
- `fluidModel`
- `solidModel`
- `fluidSolidInterface`: the fluidSolidInterface class creates its a `fluidModel` and `solidModel`

Each of these three classes is also an abstract base class, where specific fluid, solid, and fluid-solid interaction implementations derive from them.

---
#### `solids4FoamModels` Library 

Examining the `solids4FoamModels` library structure:

```bash
solids4foam
├── ...
└── src
    ├── …
    └── solids4FoamModels
        ├── ...
        ├── dynamicFvMesh
        ├── fluidModels
        ├── fluidSolidInterfaces
        ├── functionObjects
        ├── materialModels
        ├── numerics
        ├── physicsModel
        └── solidModels
```
The `fluidModel`, `solidsModel` and `fluidSolidInterface` classes are stored in separate directories. In addition, the `physicsModel` is located in the `solids4FoamModels` library.

---
#### `fluidModel` Class

Fluid models implementations that derive from the `fluidModel` base class:
- `pimpleFluid` : OpenFOAM  `pimpleDyMFoam` solver ported to a class structure. The PIMPLE algorithm generalises the PISO and SIMPLE algorithms, so `icoFoam`, `pisoFoam` and `simpleFoam` are not ported.
- `interFluid`: OpenFOAM  `interDyMFoam` solver ported to a class structure
- *...*

Each `fluidModel` corresponds to a standard fluid solver in OpenFOAM, which has been repackaged into a class form, e.g. `pimpleFluid` is a port of the `pimpleDyMFoam` standard solver.

```Note
Standard solvers in OpenFOAM can differ significantly between OpenFOAM forks. solids4foam aims to include the fork-specific solver versions, e.g. when using OpenFOAM-v2012, `pimpleFluid` is a port of `pimpleDyMFoam` from OpenFOAM-v2012.
```

#### `solidModel` Class
The `solidModel` implementations, deriving from the `solidModel` base class, include specific modelling approaches and discretisations for solid mechanics, e.g.
- `linGeomSolid`
- `thermalLinGeomSolid`
- `nonLinGeomTotalLagSolid`
- *...*

More details about the solid model can be found at https://solids4foam.github.io/documentation/solid-models.html. 

#### Fluid-Solid Interaction Class
The fluid-solid interaction models, deriving from the `fluidSolidInterface` base class, include implementations for partitioned coupling approaches, e.g.
- `fixedRelaxationCouplingInterface`
- `AitkenCouplingInterface`
- `IQNILSCouplingInterface`
- `weakCouplingInterface`
- `oneWayCouplingInterface`
- *...*

More details of the differences between these approaches can be found in [tutorial 4](https://solids4foam.github.io/tutorials/tutorial4.html).

---

## A Note on Coding Style

solids4foam aims to follow the  [OpenFOAM Coding Style Guide closely](https://openfoam.org/dev/coding-style-guide). When a consistent style is not followed, reading code generated by others becomes tedious, painstaking and even impossible. Coding style is a crucial feature of software that is easy to read, understand, maintain and extend. For example:

### Bad
```
Info <<“This is not good”
<< endl;

( a+b ) * ( c&d ) / (e&&f)

if(myName == “Philip”){
success = true;
}

…
```
### Good
```
Info<< “That’s better”
    << endl;

(a + b)*(c & d)/(e && f)

if (myName == “Philip”)
{
    success = true;
}

…
```
