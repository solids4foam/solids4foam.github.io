---
sort: 1
---

# What's new in solids4foam-v2.0?

There are many changes from `v1.0` and `v1.1` to `v2.0`; the main changes are:

* solids4foam-v2.0 compiles with newer versions of OpenFOAM and foam-extend;
* solids4foam has moved from [bitbucket](https://bitbucket.org/philip_cardiff/solids4foam-release/src/master/) to [GitHub](https://github.com/solids4foam/solids4foam);
* solids4foam has a new website (you are here now!);
* In collaboration with the preCICE development team, support has been added for using solids4foam with [preCICE](https://precice.org);
* The latest versions of solids4foam are now automatically added to the [solids4foam Docker Hub page](https://hub.docker.com/u/solids4foam);
* New solid mechanical laws have been added, including Mooney-Rivlin, Yeoh, and isotropic Fung (and Ogden [soon](https://github.com/solids4foam/solids4foam/issues/22));
* New solid models have been added, such as the [block-coupled vertex-centred](https://github.com/solids4foam/solids4foam/tree/nextRelease/src/solids4FoamModels/solidModels/vertexCentredLinGeomSolid) approach built on the [PETSc](https://petsc.org/release/) linear solver toolbox;
* The fluid models more closely follow the code from the underlying OpenFOAM version;
* The build and test scripts have been re-designed;
* A [tutorials benchmark data repository](https://github.com/solids4foam/solids4foam-tutorials-benchmark-data) has been created for storing reference data and results for the tutorials;
* solids4foam has a new logo! It is a deformed green nabla (like a deformed structure) with strings; the strings are a hat tip to the [origins of the nabla symbol](https://en.wikipedia.org/wiki/Nabla_symbol) and the [national symbol of Ireland](https://www.askaboutireland.ie/reading-room/life-society/life-society-in-ireland/overview-life-and-society/irelands-emblem/);
* The `filesToReplaceInOF` has been removed, although `optionalFixes` are still recommended when using foam-extend;
* foam-extend is no longer the primary development fork for solids4foam; instead, it is equally likely that new features will be developed in any of the three supported forks;
* There is greater support for OpenFOAM.com and OpenFOAM.org versions; for example, multi-material and solid-to-solid contact is now supported.

