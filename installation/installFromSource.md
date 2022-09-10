---
sort: 1
---

# Installing solids4foam
Installing solids4foam-v2.0 includes two easy steps, i.e., 
 - [*downloading* the source code](#downloading-the-solids4foam-source-code), and
 -  [*compiling*](#compiling-solids4foam) it. 

Before going through these steps, make sure you have a working version of OpenFOAM. If you have not OpenFOAM installed yet, we suggest downloading one the OpenFOAM versions compatible with solidsfoam, listed in the table below.

| solids4foam version | OpenFOAM version  |
| ------- | -------- |
| solids4foam-v1.0 | foam-extend-4.0 |
| solids4foam-v1.0 | foam-extend-4.1 |
| solids4foam-v1.0 | OpenFOAM-v1812 |
| solids4foam-v1.0 | OpenFOAM-v1912 |
| solids4foam-v1.0 | OpenFOAM-7 |
| ------- | -------- |
| solids4foam-v2.0 | foam-extend-4.1 |
| solids4foam-v2.0 | OpenFOAM-v2012 |
| solids4foam-v2.0 | OpenFOAM-9 |

---
## Downloading the source code

There are two ways to download the source code, ie,
- [Archive file](#archive-file);
- [Git repository](#git-repository).
### Archive file
solids4foam-v2.0 can be downloaded as an archive file. Two different archives are provided below;
you need to download one of them only. 
- TGZ: **link to be added**  
- ZIP: **link to be added**  

It can be downloaded to any reasonable location on your computer; we suggest placing it 
in `$FOAM_RUN`. In order to know where this directory is in your computer, open a terminal and
enter 
```bash
pwd $FOAM_RUN
```
After download, depending on whether `TGZ` or `ZIP` archive is downloaded, it can be extracted
using the commends below in terminal, respectively:
 ```bash
 tar xzf solids4foam.tgz
 ```
 or
 ```bash
 unzip solids4foam.zip  
 ```
### Git repository
Alternatively, solids4foam-v2.0 can be downloaded using `git` with
```bash
$> git clone --branch v2.0 https://github.com/solids4foam/solids4foam.git
```
To use a SSH key, the above command changes to
```bash
$> git clone --branch v2.0 git@github.com:solids4foam/solids4foam.git
```
## Compiling solids4foam

Before compiling solids4foam, a compatible version of OpenFOAM or foam-extend should be sourced: see the table above.

To build solids4foam, enter the solids4foam directory and exectue the included Allwmake script, e.g.
```bash
$> cd solids4foam
$> ./Allwmake 2>&1 | tee log.Allwmake
```

You can expect this build to last about 5 minutes, depending on your hardware.

If solids4foam built successfully, you will be presented with the message
```bash
There were no build errors: enjoy solids4foam!
To test the installation, run:
    > cd tutorials && ./Alltest
```

If the build encountered errors, you will receive the following message
```bash
** BUILD ERROR **"
There were build errors in the following logs:
<LIST OF COMPILATION ERRORS>

Please examine these logs for additional details
```

You can examine the source of the errors in the `log.Allwmake` file within the solids4foam parent directory. Additionally, please search [https://www.cfd-online.com/Forums/openfoam-cc-toolkits-fluid-structure-interaction/](https://www.cfd-online.com/Forums/openfoam-cc-toolkits-fluid-structure-interaction/) for similar errors. If you cannot find a resolution, please create a new thread at [https://www.cfd-online.com/Forums/openfoam-cc-toolkits-fluid-structure-interaction/](https://www.cfd-online.com/Forums/openfoam-cc-toolkits-fluid-structure-interaction/). Alternatively, if you beleive that you have encountered a bug then please create a new issue at [https://github.com/solids4foam/solids4foam/issues](https://github.com/solids4foam/solids4foam/issues).

---

## Testing the installation

As instructed after a succesful build, you can test that the tutorials using the following commands, executed from the solids4foam parent directory
```bash
$> cd tutorials && ./Alltest
```

You can expect these tests to last a few minutes.

If the tests pass, you will receive the message
```bash
All tests passed: enjoy solids4foam.
```
This means your solids4foam installation is working as expected.

If any of the tests fail, you will receive the message
```bash
The solids4Foam solver failed on the following cases:
<LIST OF FAILING TUTORIALS>
```
or, if the errors do not come from the solids4foam calls, but elsewhere
```bash
The following commands failed:
<LIST OF FAILING COMMANDS AND TUTORIALS>
```

---

## What next?

Please see the **tutorial guide (LINK TO BE ADDED)**.
### `development` branch
If you would like the latest `development` branch, it can be downloaded with
```bash
$> git clone --branch development https://github.com/solids4foam/solids4foam.git
```
or
```bash
$> git clone --branch development git@github.com:solids4foam/solids4foam.git
```

---
## Dependencies

```tip
These dependencies are optional. If you would like to get up and running quickly, you can skip them!
```
Beyond a working version of OpenFOAM or foam-extend, solids4foam does not have any **mandatory** dependencies; however, several **optional** dependencies are required to use the full set of functionalities:

| Dependency  | Required for  |
| ------- | -------- |
| Eigen | Block-coupled cell-centred and vertex-centred solid models linear solvers |
| PETSc | Block-coupled vertex-centred solid models linear solvers |
| gfortran | Abaqus UMAT mechanical law interface |
| cfmesh | Some tutorials use cfmesh for creating the meshes |
| gnuplot | Some tutorials use gnuplot to generate graphs after running the solver |

### Eigen

Before building solids4foam, the `EIGEN_DIR` environment variable can be set to the local Eigen installation location. If `EIGEN_DIR` is not set then solids4foam will download its own local copy of Eigen.

### PETSc

The binaries for PETSc can be installed on Ubuntu with
```bash
$> sudo apt install petsc-dev
```
Or, on macOS with
```bash
$> brew install petsc
```
Alternatively, and more generally, PETSc can be installed following the instructions at [https://petsc.org/release/](https://petsc.org/release/).

Once PETSC has been installed, the `PETSC_DIR` environment variable should be set to the installation location; this allows solids4foam to use it. If the `PETSC_DIR` environment variable is not set, then solids4foam will not use PETSc and functionalities that require PETSc will be disabled.

### gfortran

gfortran can be installed on Ubuntu with:
```bash
$> sudo apt-get install gfortran
```
Or, on macOS with
```bash
$> brew install gcc
```

```warning
If the GCC compilers were used to compile OpenFOAM or foam-extend, then a compatible version of gfortran should be installed. For example, gfortran-7 should be used with gcc-7.
```

solids4foam will use gfortran if the `gfortran` executable is found in the `$PATH`; if it is not found then solids4foam will disable functionalities that require gfortran.

### cfmesh

A small number of tutorials require the `cartesianMesh` utility from cfmesh. If the `cartesianMesh` executable is not found within the `$PATH` then the `Allrun` script within these tutorials will exit.

```tip
- **foam-extend**: cfmesh is included in foam-extend.
- **OpenFOAM.com (OpenCFD/ESI version)**: compatible versions of cfmesh can be installed from (https://develop.openfoam.com/Community/integration-cfmesh)[https://develop.openfoam.com/Community/integration-cfmesh].
- **OpenFOAM.org (Foundation version)**: the free version of cfmesh is currently not compatible with OpenFOAM.org versions.
```

### gnuplot

gnuplot can be installed on Ubuntu with:
```bash
$> sudo apt-get install gnuplot
```
Or, on macOS with
```bash
$> brew install gnuplot
```

---


