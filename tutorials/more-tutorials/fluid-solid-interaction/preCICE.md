---
sort: 10
---

# Using solids4foam with preCICE

---

[preCICE](https://precice.org) is an open-source coupling library for
partitioned multi-physics simulations. It can couple a solids4foam solid solver
to an OpenFOAM fluid solver, or to any other fluid solver preCICE supports,
as an alternative to solids4foam's own fluid-solid interaction solvers.

Both preCICE and the preCICE OpenFOAM adapter must be installed:

- [preCICE quickstart](https://precice.org/quickstart.html)
- [OpenFOAM adapter](https://precice.org/adapter-openfoam-overview.html)

---

## Where the cases live

solids4foam's preCICE cases are maintained upstream, in the
[precice/tutorials](https://github.com/precice/tutorials) repository, not in the
solids4foam repository. Start with
[perpendicular-flap](https://precice.org/tutorials-perpendicular-flap.html),
whose `solid-solids4foam` participant is the reference solids4foam
configuration, and see the full
[list of preCICE tutorials](https://precice.org/tutorials.html).

These cases are run against the solids4foam development branch in solids4foam's
own continuous integration, as well as by the preCICE system tests, so they
track both projects.

---

## Archived cases

Up to and including **v2.4**, the solids4foam repository also carried two
standalone preCICE cases in `tutorials/fluidSolidInteraction-preCICE`:

- `flexibleOversetCylinder`, an overset fluid mesh coupled to a deformable
  ring, documented on
  [its own page](https://www.solids4foam.com/tutorials/more-tutorials/fluid-solid-interaction/flexibleOversetCylinder.html);
- `3dTube`, the preCICE version of the
  [`3dTube`](https://www.solids4foam.com/tutorials/more-tutorials/fluid-solid-interaction/3dTube.html)
  fluid-solid interaction case.

They were removed after v2.4, as no test covered them. The case files remain
available here:

- [fluidSolidInteraction-preCICE.zip](https://www.solids4foam.com/tutorials/archive/fluidSolidInteraction-preCICE.zip)

```warning
The archived cases are provided as they were at the time of removal. They are
not tested against current solids4foam, preCICE or OpenFOAM adapter releases,
and may need updating before they run.
```
