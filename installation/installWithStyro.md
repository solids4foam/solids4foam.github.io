# Installing solids4foam with styro

## What is styro?

**[styro](https://github.com/gerlero/styro)** is a lightweight package manager
 for OpenFOAM-related software. It provides a simple way to install and manage
 pre-built packages without manually compiling from source.

styro currently supports:

- **OpenFOAM.com (OpenCFD/ESI)**
- **OpenFOAM.org (Foundation)**

> Note: styro does *not* support foam-extend.

Using styro to install **solids4foam** is an alternative to building from source
or using Docker, and is particularly convenient for users who want a quick,
repeatable setup.

---

## Prerequisites

Before using styro:

1. Install and source a supported version of OpenFOAM
   (OpenFOAM.com or OpenFOAM.org).
2. Ensure the OpenFOAM environment is active (e.g. `FOAM_USER_APPBIN` is defined).

styro installs the **solids4foam binaries** into:

```bash
$FOAM_USER_APPBIN
```

which is the same location used by a standard solids4foam build from source.

The solids4foam source tree managed by styro is placed at:

```bash
$FOAM_USER_APPBIN/../styro/pkg/solids4foam
```

---

## Installing styro

For a full list of available installation options, see [github.com/gerlero/styro](https://github.com/gerlero/styro).

### Ubuntu / Debian Linux

Install styro using `pip`:

```bash
pip install styro
```

---

### macOS

Using Homebrew (recommended):

```bash
brew install gerlero/tap/styro
```

---

## Installing solids4foam

First, source your OpenFOAM installation, for example:

```bash
source /lib/openfoam/OpenFOAM-v2412/etc/bashrc   # OpenFOAM.com
# or
source /opt/openfoam9/etc/bashrc                 # OpenFOAM.org
```

Then install solids4foam using styro:

```bash
styro install solids4foam
```

styro will:

- Download the latest `master` branch solids4foam package from the solids4foam
  GitHub page
- Compile (if required) against the currently loaded OpenFOAM version
- Install binaries into `$FOAM_USER_APPBIN`

---

## Verifying the installation

Check that a solids4foam solver is available:

```bash
which solids4Foam
```

or list installed applications:

```bash
ls $FOAM_USER_APPBIN | grep solid
```

You can then run any solids4foam tutorial in the usual way.

---

## When should I use styro?

styro is particularly useful if you:

- Want a **simple, reproducible installation**
- Prefer **not** to manually manage builds
- Regularly switch between OpenFOAM versions

For full control, development work, or unsupported OpenFOAM variants,
installing solids4foam from source may still be preferable.
