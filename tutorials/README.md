---
sort: 2
---

# Tutorials Guide

The solids4foam tutorials are organised into fluids, solids and fluid-solid interaction cases, where physical phenomena further categorise the solid tutorials:
```bash
tutorials
├── …
├── fluidSolidInteraction
│   └── …
├── fluids
│   └── …
└── solids
    ├── elastoplasticity
    ├── fracture
    ├── hyperelasticity
    ├── linearElasticity
    ├── multiMaterial
    ├── poroelasticity
    ├── thermoelasticity
    └── viscoelasticity
```

All solids4foam cases require a `physicsProperties` dictionary in the `constant` directory, where either a `solid`, `fluid` or `fluidSolidInteraction` analysis is specified, e.g.
```c++
//type  fluid;
type    solid;
//type  fluidSolidInteraction;
```
If a solid analysis is selected, then a `solidProperties` dictionary is required in the constant directory; similarly, the `fluidProperties` dictionary is required for a fluid analysis, and the `fsiProperties` dictionary for a fluid-solid interaction analysis. These dictionaries let us specify what type of solid, fluid or fluid-solid interaction analysis is to be performed.


## Running the Tutorials Using a Native Installation

```tip
We suggest making a backup copy of the solids4foam tutorials in case you want to reset them. Alternatively, you can reset them with git.
```

Change the directory to the “run” directory (create the directory if needed):
```bash
> mkdir -p $FOAM_RUN && run
```

Copy the solids4foam tutorials to the run directory; note: it is assumed here that solids4foam is installed at `$FOAM_RUN/..`:
```bash
> cp -r $FOAM_RUN/../solids4foam/tutorials .
```

All solids4foam tutorials contain `Allrun` and `Allclean` scripts. To run a given tutorial case, navigate to its directory and execute the `Allrun` script; for example, this can be done for the `hotSphere` tutorial with
```bash
> cd $FOAM_RUN/../solids4foam/tutorials/solids/thermoelasticity/hotSphere
> ./Allrun
```
where we have assumed that solids4foam was downloaded to `$FOAM_RUN/..`.

The tutorial results can be visualised in ParaView using one of the following commands:
```bash
> paraFoam
> paraFoam -nativeReader
> touch case.foam && paraview case.foam
```

## Running the Tutorials using a Docker Installation

If you are using the solids4foam docker image, it is not convenient to directly open ParaView from within the image, so a workaround is to copy the tutorials to the shared directory in the docker container `/shared`:
```bash
> cd /shared
> cp -r $FOAM_RUN/../solids4foam/tutorials .
```
This `/shared` directory points directly to the `$HOME` directory on your physical computer (or where ever you mounted it). You can now open a second terminal (on your physical computer, NOT in the docker container) and use ParaView installed on your *physical computer* to view the cases in your `$HOME` directory.

Here is an example of using ParaView on your physical computer to view cases created in the docker container:

- In the Docker terminal
```bash
> cd /shared
> cp -r $FOAM_RUN/../solids4foam/tutorials .
> cd tutorials/solids/thermoelasticity/hotSphere
> ./Allrun
```
- In the terminal on your physical computer
```bash
> cd ~/tutorials/solids/thermoelasticity/hotSphere
> touch case.foam && paraview case.foam
> # or paraFoam
> # or paraFoam -nativeReader
```


---

# Tutorial Guides

{% include list.liquid all=true %}
