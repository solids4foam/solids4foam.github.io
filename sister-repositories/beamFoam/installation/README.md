---
sort: 1
---

# Installation

beamFoam is built from source against an existing OpenFOAM.com installation.
The repository's build script currently recognises OpenFOAM versions `v2106`
through `v2506`, at six-month release intervals. OpenFOAM `v2306` is the
principal tested version described in the beamFoam paper.

## Prerequisites

- A supported OpenFOAM.com installation
- Git and a C++ build environment suitable for OpenFOAM
- Eigen, which is provided under `ThirdParty/` and built by the top-level
  script when required

Source the OpenFOAM environment before installing beamFoam. For example:

```bash
> source /path/to/OpenFOAM-v2306/etc/bashrc
```

Confirm that the environment is active:

```bash
> echo $WM_PROJECT_VERSION
> which wmake
```

## Download and Build

A convenient location is beside the OpenFOAM run directory:

```bash
> mkdir -p $FOAM_RUN
> cd $FOAM_RUN/..
> git clone https://github.com/solids4foam/beamFoam.git
> cd beamFoam
> ./Allwclean
> ./Allwmake
```

The top-level build script builds the Eigen dependency, beam model library,
`beamFoam` solver, utilities and helper scripts. It reports a build error if
errors are found in the generated build logs.

## Verify the Installation

After a successful build, verify that the main applications are available:

```bash
> which beamFoam
> which createBeamMesh
> which setInitialPositionBeam
```

Run one of the supplied cases to verify the complete workflow:

```bash
> cd tutorials/cantilever
> ./Allclean
> ./Allrun
```

See the [tutorial guide](../tutorials/README.md) for the featured validation
cases and post-processing instructions.

## Cleaning and Rebuilding

To remove generated build products and rebuild:

```bash
> cd $FOAM_RUN/../beamFoam
> ./Allwclean
> ./Allwmake
```

When changing OpenFOAM versions, clean beamFoam before rebuilding it in the new
environment.
