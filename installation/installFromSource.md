---
sort: 1
---

# Installing solids4foam from Source

---

## Quickstart

Source a [supported version of OpenFOAM](#supported-versions-of-openfoam), then download, build and test solids4foam-v2.0:
```bash
> git clone --branch v2.0 git@github.com:solids4foam/solids4foam.git
> cd solids4foam && ./Allwmake && ./Alltest
```

For a detailed installation guide, see below.


---

## Detailed Installation Guide

---

### Supported Versions of OpenFOAM/foam

solids4foam requires a working version of OpenFOAM or foam-extend. Currently, the following OpenFOAM versions are supported:

| solids4foam version | OpenFOAM/foam version |
| ------- | -------- |
| solids4foam-v1.* | foam-extend-4.0 |
|  | foam-extend-4.1 |
|  | OpenFOAM-v1812 |
|  | OpenFOAM-v1912 |
|  | OpenFOAM-7 |
| ------- | -------- |
| solids4foam-v2.* | foam-extend-4.1 |
|  | OpenFOAM-v2012 |
|  | OpenFOAM-9 |

#### Note on using foam-extend-4.1
If you are using foam-extend-4.1, the solids4foam `Allwmake` script will ask you to fix two files in the foam-extend-4.1 installation:
  * `meshObjectBase.H`: without this fix, all runs will end in a segmentation. The solids4foam solver will work correctly; however, you may like to fix this if you plan to catch the return valve from the solver.
  * `pointBoundaryMesh.C`: without this fix, cases involving topological mesh changes will have a segmentation fault. For example, when using `crackerFvMesh`.

To make these fixes, follow the instructions from the `Allwmake` script when [building solids4foam](#building-solids4foam).

If you do not want to (or cannot) make these changes, please set the environmental variable `S4F_NO_FILE_FIXES=1` before running the Allwmake script when [building solids4foam](#building-solids4foam), e.g.
```
> export S4F_NO_FILE_FIXES=1 && ./Allwmake
```

---

### Dependencies

```tip
These dependencies are optional. You can skip them if you want to get up and running quickly.
```
Beyond a working version of OpenFOAM or foam-extend, solids4foam does not have any **mandatory** dependencies; however, several **optional** dependencies are required to use the complete set of functionalities:

| Dependency  | Functionality Provided |
| ------- | -------- |
| Eigen | Block-coupled cell-centred and vertex-centred solid models linear solvers |
| PETSc | Block-coupled vertex-centred solid models linear solvers |
| gfortran | Abaqus UMAT mechanical law interface |
| cfmesh | Some tutorials use cfmesh for creating the meshes |
| gnuplot | Some tutorials use Gnuplot to generate graphs after running the solver |

#### Eigen

Before building solids4foam, the `EIGEN_DIR` environment variable can be set to the local Eigen installation location. If `EIGEN_DIR` is not set, then solids4foam will download a local copy of Eigen.

If you would like solids4foam **not** to use Eigen (e.g. due to version conflicts when using preCICE), set the `S4F_NO_USE_EIGEN` environment variable, e.g. add the following to your bashrc

```bash
> export S4F_NO_USE_EIGEN=1
```

#### PETSc

The binaries for PETSc can be installed on Ubuntu with
```bash
> sudo apt install petsc-dev
```
Or, on macOS with
```bash
> brew install petsc
```
Alternatively, and more generally, PETSc can be installed following the instructions at [https://petsc.org/release/](https://petsc.org/release/).

Once PETSC has been installed, the `PETSC_DIR` environment variable should be set to the installation location; this allows solids4foam to use it. If the `PETSC_DIR` environment variable is not set, then solids4foam will not use PETSc and functionalities that require PETSc will be disabled. For example, on Ubuntu you can do this with:
```bash
ecport PETSC_DIR=/lib/petsc
```
Or, if using homebrew, on macOS (you may need to update the version number)
```bash
export PETSC_DIR=/opt/homebrew/Cellar/petsc/3.17.2
```
```tip
Add the export PETSC_DIR statement to your ~/.bashrc file to set this variable for new terminal sessions automatically.
```

#### gfortran

gfortran can be installed on Ubuntu with:
```bash
> sudo apt-get install gfortran
```
Or, on macOS with
```bash
> brew install gcc
```

```warning
If the GCC compilers were used to compile OpenFOAM or foam-extend, then a compatible version of gfortran should be installed. For example, gfortran-7 should be used with gcc-7.
```

solids4foam will use gfortran if the `gfortran` executable is found in the `$PATH`; if not, solids4foam will disable functionalities that require gfortran.

#### cfmesh

A small number of tutorials require the `cartesianMesh` utility from cfmesh. If the `cartesianMesh` executable is not found within the `$PATH` then the `Allrun` script within these tutorials will exit.

```tip
- **foam-extend**: cfmesh is included in foam-extend.
- **OpenFOAM.com (OpenCFD/ESI version)**: compatible versions of cfmesh can be installed from [https://develop.openfoam.com/Community/integration-cfmesh](https://develop.openfoam.com/Community/integration-cfmesh).
- **OpenFOAM.org (Foundation version)**: the free version of cfmesh is currently not compatible with OpenFOAM.org.
```

#### gnuplot

gnuplot can be installed on Ubuntu with:
```bash
> sudo apt-get install gnuplot
```
Or, on macOS with
```bash
> brew install gnuplot
```

---

### Downloading the solids4foam Source Code

The solids4foam directory can be downloaded to any reasonable location on your computer; we suggest placing it in `$FOAM_RUN/..`.

#### Archive file
solids4foam-v2.0 can be downloaded as an archive file:
- [solids4foam-v2.0.zip](https://github.com/solids4foam/solids4foam/archive/refs/tags/v2.0.zip): extracted with `> unzip v2.0.tar.gz`
- [solids4foam-v2.0.tgz](https://github.com/solids4foam/solids4foam/archive/refs/tags/v2.0.tar.gz): extracted with `> tar xzf unzip v2.0.tar.gz`


#### Git repository: v2.0
`solids4foam-v2.0` can be downloaded using git with
```bash
> git clone --branch v2.0 git@github.com:solids4foam/solids4foam.git
```

#### Git repository: latest development branch
The latest development branch can be downloaded with
```bash
> git clone --branch development git@github.com:solids4foam/solids4foam.git
```

---

### Building solids4foam

Before building solids4foam, a compatible version of OpenFOAM or foam-extend should be sourced: see the [table above](#supported-versions-of-openfoam). To build solids4foam, enter the solids4foam directory and execute the included Allwmake script, e.g.

```bash
> cd solids4foam
> ./Allwmake 2>&1 | tee log.Allwmake
```

Depending on your hardware, you can expect this build to last about 5 minutes.

If solids4foam is built successfully, you will be presented with the following message:
```bash
There were no build errors: enjoy solids4foam!
To test the installation, run:
    > cd tutorials && ./Alltest
```

If the build encounters errors, you will receive the following message:
```bash
** BUILD ERROR **"
There were build errors in the following logs:
<LIST OF COMPILATION ERRORS>

Please examine these logs for additional details
```

You can examine the source of the errors in the `log.Allwmake` file within the solids4foam parent directory. Additionally, please search [https://www.cfd-online.com/Forums/openfoam-cc-toolkits-fluid-structure-interaction/](https://www.cfd-online.com/Forums/openfoam-cc-toolkits-fluid-structure-interaction/) for similar errors. If you cannot find a resolution, please create a new thread at [https://www.cfd-online.com/Forums/openfoam-cc-toolkits-fluid-structure-interaction/](https://www.cfd-online.com/Forums/openfoam-cc-toolkits-fluid-structure-interaction/). Alternatively, if you believe you have encountered a bug, please create a new issue at [https://github.com/solids4foam/solids4foam/issues](https://github.com/solids4foam/solids4foam/issues).

---

### Testing the Installation

As instructed, after a successful build, you can test the tutorials using the following commands, executed from the solids4foam parent directory.
```bash
> cd tutorials && ./Alltest
```

You can expect these tests to last a few minutes.

If the tests pass, you will receive the message:
```bash
All tests passed: enjoy solids4foam.
```
This means your solids4foam installation is working as expected.

If any of the tests fail, you will receive the message:
```bash
The solids4Foam solver failed in the following cases:
<LIST OF FAILING TUTORIALS>
```
or if the errors do not come from the solids4foam calls but elsewhere
```bash
The following commands failed:
<LIST OF FAILING COMMANDS AND TUTORIALS>
```

---

## What Next?

Please see the [tutorial guide](../tutorials/README.md).