---
sort: 3
---

# Tutorials

The beamFoam tutorials are ready-to-run validation and example cases stored
under the repository's `tutorials/` directory. Each case uses the standard
OpenFOAM case structure and provides `Allrun` and `Allclean` scripts.

## Tutorial Workflow

Source OpenFOAM and ensure beamFoam is compiled before running a tutorial. A
typical workflow is:

```bash
> cd $FOAM_RUN/../beamFoam/tutorials/3DdynamicCantilever
> ./Allclean
> ./Allrun
```

The scripts generally:

1. Create the one-dimensional beam mesh using `createBeamMesh`.
2. Optionally rotate or translate the initial beam using
   `setInitialPositionBeam`.
3. Run the `beamFoam` solver.
4. Generate validation plots using gnuplot, when plotting scripts are supplied.

Clean a case before repeating it or after changing its mesh, time step or time
scheme:

```bash
> ./Allclean
```

## Post-Processing

Open the generated case in ParaView:

```bash
> touch case.foam
> paraview case.foam
```

Apply **Warp By Vector** using `pointW` to visualise the deformed beam. Function
objects under `system/controlDict` write histories such as end displacement,
forces, moments, nonlinear convergence and beam energy under `postProcessing/`.

## Paper Benchmark Cases

The following navigable guides describe the three principal validation cases
from the [beamFoam paper](https://doi.org/10.51560/ofj.v5.170), including their
physical setup, dictionaries, execution, post-processing and expected results.

{% include list.liquid all=true %}

## Other Repository Tutorials

The repository also includes:

- [`cantilever`](https://github.com/solids4foam/beamFoam/tree/main/tutorials/cantilever):
  pure bending under a concentrated end moment
- [`largeDeflectionCantilever`](https://github.com/solids4foam/beamFoam/tree/main/tutorials/largeDeflectionCantilever):
  a rectangular cantilever under self-weight
- [`3DdynamicCantileverMultiBeamDensity`](https://github.com/solids4foam/beamFoam/tree/main/tutorials/3DdynamicCantileverMultiBeamDensity):
  independent cantilevers with different densities

See the complete
[`tutorials/` directory](https://github.com/solids4foam/beamFoam/tree/main/tutorials)
for development and coupled cases that do not yet have detailed website guides.
