---
sort: 1
---

# Release notes

---

## What's new in solids4foam-v2.3?

The changes from `v2.2` to `v2.3` are:

- Cooks membrane tutorial case by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/46>
- CHT with explicit coupling based on robin bc by @philipcardiff in <https://github.com/solids4foam/solids4foam/pull/50>
- fixed problem with poroMechLaw when used with a stress state dependen effStressMechLaw
  by @denMaier in <https://github.com/solids4foam/solids4foam/pull/52>
- Added elastoPlastic cooksMembrane and linearElastic curvedCantilever by @iBatistic
  in <https://github.com/solids4foam/solids4foam/pull/54>
- change petsc build options to use petscvariables by @guoxiaohu in <https://github.com/solids4foam/solids4foam/pull/40>
- Added contact patch test tutorial by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/55>
- Added flat ended rigid indenter contact case by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/57>
- Fix Robin condition for ESI and Foundation versions by @philipcardiff in <https://github.com/solids4foam/solids4foam/pull/59>
- Plot file path and file name correction for foam-extend-4.1 by @cloner0110 in <https://github.com/solids4foam/solids4foam/pull/58>
- fix flatEndedRigidIndenter to work with v2012 by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/61>
- Documentation draft for solids4foamScripts.sh bash script by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/62>
- updates to compile with OpenFOAM-v2306 by @olesenm in <https://github.com/solids4foam/solids4foam/pull/60>
- Modified solids4FoamChangeCopyright.sh to delete banner by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/66>
- GitHub Action for solids4FoamChangeCopyright.sh; Reply to #69 by @iBatistic
  in <https://github.com/solids4foam/solids4foam/pull/70>
- general fix to force postprocessing by @cloner0110 in <https://github.com/solids4foam/solids4foam/pull/71>
- Added utility README file, finished scripts README by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/75>
- Fix for arguments in addTinyPatch.C by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/76>
- Small fix for bolded text in scripts README.md by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/77>
- Small fixes in utility/README.md by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/78>
- Replacing NamedEnum with Enum for OPENFOAM_COM by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/79>
- added a function to recalculate rho by @denMaier in <https://github.com/solids4foam/solids4foam/pull/82>
- Typo fix in hydrostaticPressure.H by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/85>
- Feature run multi region case as single case by @denMaier in <https://github.com/solids4foam/solids4foam/pull/83>
- Added readme file for functionObjects by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/87>
- Closes solids4foam/solids4foam#72 Feature write out dicts with default values
  by @denMaier in <https://github.com/solids4foam/solids4foam/pull/81>
- Update for layeredPipe tutorial case by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/94>
- README file for punch tutorial case by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/96>
- Minor update to layeredPipe README.md by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/97>
- Added curvedBeams case by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/98>
- modified flexibleDamBreak Tutorial by @cloner0110 in <https://github.com/solids4foam/solids4foam/pull/99>
- Updates to tutorial README.md files by @philipcardiff in <https://github.com/solids4foam/solids4foam/pull/100>
- Solution of #90 by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/102>
- Port to OpenFOAM-v2312 by @philipcardiff in <https://github.com/solids4foam/solids4foam/pull/101>
- compile solids4Foam as dockeruser and not as root in docker container for
  foam-extend-4.1 by @hoehnp in <https://github.com/solids4foam/solids4foam/pull/34>
- Updates to tutorial README.md files  by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/104>
- Typo fix in fixedDisplacementFvPatchVectorField.H by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/106>
- changed the initialization of sigmaSubMesh to get it from baseMesh by @denMaier
  in <https://github.com/solids4foam/solids4foam/pull/110>
- Fix in optionalFixes/Allcheck script by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/113>
- Header fix for solidTorque output file by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/115>
- minor fix on solids4FoamScripts.sh by @cloner0110 in <https://github.com/solids4foam/solids4foam/pull/109>
- Make denom always displacement increment in solidModel::converged by @iBatistic
  in <https://github.com/solids4foam/solids4foam/pull/117>
- Fix for symmetryPlane point location correction in solidModel by @iBatistic
  in <https://github.com/solids4foam/solids4foam/pull/118>
- Removed stressName from solidTorque by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/123>
- Fix for last update of solidTorque.C #123 by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/124>
- Segment contact procedure by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/125>
- Feature vertex centred merge by @philipcardiff in <https://github.com/solids4foam/solids4foam/pull/126>
- Link to tutorial files (featured tutorials) by @MakisH in <https://github.com/solids4foam/solids4foam/pull/148>
- Hint where the test logs are by @MakisH in <https://github.com/solids4foam/solids4foam/pull/145>
- Update preCICE configuration files to v3 by @MakisH in <https://github.com/solids4foam/solids4foam/pull/146>
- Fixes and hints related to the optional file fixes by @MakisH in <https://github.com/solids4foam/solids4foam/pull/147>
- Solution for #122 by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/138>
- Added CONTRIBUTING.md file by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/152>
- Fix for getNumberOfProcessors() & removing compression specifier warning by
  @iBatistic in <https://github.com/solids4foam/solids4foam/pull/153>
- Fix syntax typo in beamInCrossFlow tutorial by @MakisH in <https://github.com/solids4foam/solids4foam/pull/154>
- [Feature] squarePlateAnalyticalSolution by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/171>
- [Feature] Update `.gitignore` to ignore `clangd` files by @abzrg in <https://github.com/solids4foam/solids4foam/pull/161>
- Refactor update deprecated keywords by @abzrg in <https://github.com/solids4foam/solids4foam/pull/176>
- Updated K value for plane stress by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/178>
- Fix for issue #2711 (openfoam.com) by @MatheusMiguel12 in <https://github.com/solids4foam/solids4foam/pull/182>
- Fix: Removed ANSI escape sequences by @SMArndt in <https://github.com/solids4foam/solids4foam/pull/186>
- Merge new PETSc SNES interface into development by @philipcardiff in <https://github.com/solids4foam/solids4foam/pull/191>
- Feature high order by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/199>
- Add support for Robin copling with interFluid by @philipcardiff in <https://github.com/solids4foam/solids4foam/pull/200>
- Added README for plateHole case by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/203>
- `cavityWithFlexibleBottom` tutorial by @iBatistic in <https://github.com/solids4foam/solids4foam/pull/204>
- Development - v2.3 by @philipcardiff in <https://github.com/solids4foam/solids4foam/pull/202>
- Development - OpenFOAM-v2512 compatibility by @philipcardiff in <https://github.com/solids4foam/solids4foam/pull/205>
- Development by @philipcardiff in <https://github.com/solids4foam/solids4foam/pull/206>
- Development by @philipcardiff in <https://github.com/solids4foam/solids4foam/pull/207>
>
### New Contributors>
>
- @denMaier made their first contribution in <https://github.com/solids4foam/solids4foam/pull/52>
- @guoxiaohu made their first contribution in <https://github.com/solids4foam/solids4foam/pull/40>
- @olesenm made their first contribution in <https://github.com/solids4foam/solids4foam/pull/60>
- @hoehnp made their first contribution in <https://github.com/solids4foam/solids4foam/pull/34>
- @MakisH made their first contribution in <https://github.com/solids4foam/solids4foam/pull/148>
- @MatheusMiguel12 made their first contribution in <https://github.com/solids4foam/solids4foam/pull/182>
- @SMArndt made their first contribution in <https://github.com/solids4foam/solids4foam/pull/186>

### Full Changelog

<https://github.com/solids4foam/solids4foam/compare/v2.2...v2.3>

---

## What's new in solids4foam-v2.2?

The main changes from `v2.1` to `v2.2` are:

- solids4foam-v2.2 compiles with OpenFOAM-v2012 to OpenFOAM-v2412, OpenFOAM-9,
  and foam-extend-4.1

- Added CITATION.cff file

- Introduced OPENFOAM_NOT_EXTEND, OPENFOAM_COM, OPENFOAM_ORG defs aligning more
  with swak4foam, improve readability etc
  - OPENFOAM_COM         (replaces: OPENFOAMESI)
  - OPENFOAM_ORG         (replaces: OPENFOAMFOUNDATION)
  - OPENFOAM_NOT_EXTEND  (replaces: OPENFOAMESIORFOUNDATION)

- Centralise wmake-options, provision for OpenFOAM/modules integration

- Parse Allwmake arguments in high-level Allwmake

- New tutorials and README.mds, and fixes for existing tutorials

- Update Alltest to catch non-foam errors

- New GitHub actions to catch whitespace, enforce lint rules and check
  copyrights

- Added applications/utilities/README.md

- Added contact patch test tutorial

- Added applications/scripts/README.md

- Fixes and updates for material models

- Added README for functionObjects

- Write all dicts with default values to show the users the silent options

- Added vertex centred solid model

- Added transformStressToCylindrical function object

- Added README.md for punch tutorial case

- Added layeredPipe README.md

- Added curvedBeams case

- Added elastoplasticity curvedBeams README.md

- Updated the README.md in flexibleDamBreak

- Added README for slabCooling case

- Added readme for hotCylinder

- Added README for viscoTube

- Added README file for pressurisedCylinder case

- Added README file for neckingBar case

- Added README file for cylinderExpansion

- Boundary condition updates and fixes

- Add README.md for HronTurekFsi3

- 3dTube merged with 3dTubeRobin

- fluidSolidInterface: add new residual calculation option, but defaults to
  original incrementalResiduals approach

- Add optionalFixes/README.md

- Add segment-to-segment contact procedure based on volume intersection

- Added GuccioneElastic and electroMechanicalLaw mechanical laws

- Added enhancedVolPointInterpolation

- Ports more cases to all variants of OpenFOAM

- Add rigidRotation README

- Create LICENSE file

- linearElasticity/plateHole: use analytical solution and boundary conditions

- Added CONTRIBUTING.md file

- Added markdownlint.yml for checking all markdown files

- Added GitHub action to update the soldis4foam.github.io repository

- Add GitHub Action to remove trailing whitespace

- Add normalDisplacementZeroShear boundary condition

---

## What's new in solids4foam-v2.1?

The main changes from `v2.0` to `v2.1` are:

- solids4foam-v2.1 compiles with OpenFOAM-v2012 to OpenFOAM-v2312, OpenFOAM-9,
  and foam-extend-4.1;
- Conjugate heat transfer and thermo-fluid-solid interaction capabilities have
  been added;
- README.md files have been added to more tutorials and to the website;
- New tutorials have been added;
- A segment-to-segment contact procedure has been added to the `solidContact`
  boundary condition;
- Many bugs have been fixed, and refactorings have been performed;
- A new general vertex-centred solid model `vertexCentredLinearGeometry` has
  been created, allowing run-time selection of a block-coupled, segregated or
  explicit solution algorithm;
- A new block-coupled nonlinear geometry vertex-centred solid model has been
  added: `vertexCentredNonLinTotalLagGeometry`;
- The general `electroMechanicalLaw` has been added;
- The general `poroMechLaw` has been added;
- The `GuccioneElastic` mechanical law has been added;
- The Robin-Neumann fluid-solid interaction coupling now works with OpenFOAM.com
  and OpenFOAM.org versions;
- Centralised the wmake-options and made a provision for OpenFOAM/modules
  integration;
- Refactored compiler directives for the different versions, e.g.
  OPENFOAMESIORFOUNDATION -> OPENFOAM_NOT_EXTEND;
- Case dictionaries now get written with their default values to
  `<dictName>.withDefaultValues`;
- Refactoring of GitHub actions;
- Ported kirchhoffPlateSolid solid model and the squarePlate tutorial to
  OpenFOAM.com.

---

## What's new in solids4foam-v2.0?

The main changes from `v1.0` and `v1.1` to `v2.0` are:

- solids4foam-v2.0 compiles with newer versions of OpenFOAM and foam-extend;
- solids4foam has moved from
  [bitbucket](https://bitbucket.org/philip_cardiff/solids4foam-release/src/master/)
  to [GitHub](https://github.com/solids4foam/solids4foam);
- solids4foam has a new website (you are here now!);
- In collaboration with the preCICE development team, support has been added for
  using solids4foam with [preCICE](https://precice.org);
- The latest versions of solids4foam are now automatically added to the
  [solids4foam Docker Hub page](https://hub.docker.com/u/solids4foam);
- New solid mechanical laws have been added, including Mooney-Rivlin, Yeoh, and
  isotropic Fung (and Ogden
  [soon](https://github.com/solids4foam/solids4foam/issues/22));
- New solid models have been added, such as the
  [block-coupled vertex-centred](https://github.com/solids4foam/solids4foam/tree/nextRelease/src/solids4FoamModels/solidModels/vertexCentredLinGeomSolid)
  approach built on the [PETSc](https://petsc.org/release/) linear solver
  toolbox;
- The fluid models more closely follow the code from the underlying OpenFOAM
  version;
- The build and test scripts have been re-designed;
- A
  [tutorials benchmark data repository](https://github.com/solids4foam/solids4foam-tutorials-benchmark-data)
  has been created for storing reference data and results for the tutorials;
- solids4foam has a new logo! It is a deformed green nabla (like a deformed
  structure) with strings; the strings are a hat tip to the
  [origins of the nabla symbol](https://en.wikipedia.org/wiki/Nabla_symbol) and
  the
  [national symbol of Ireland](https://www.askaboutireland.ie/reading-room/life-society/life-society-in-ireland/overview-life-and-society/irelands-emblem/);
- The `filesToReplaceInOF` has been removed, although `optionalFixes` are still
  recommended when using foam-extend;
- foam-extend is no longer the primary development fork for solids4foam;
  instead, it is equally likely that new features will be developed in any of
  the three supported forks;
- Greater support is available for OpenFOAM.com and OpenFOAM.org versions; for
  example, multi-material and solid-to-solid contact is now supported.
