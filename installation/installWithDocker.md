---
sort: 3
---

# Installing solids4foam with Docker

---

## What is Docker?

[Docker](https://www.docker.com) is an open source software platform for
creating, deploying and managing virtualized application _containers_. Using
docker we can essentialy create a light-weight virtual machine with solids4foam
and its dependencies already installed.

---

## How do I Install Docker?

Docker can be installed on Windows, macOS and Linux by following the
instructions on the [Docker website](https://docs.docker.com/get-docker/).

---

## Creating the solids4foam Docker Container

In macOS and Linux, the solids4foam container can be created with
 (OpenFOAM-v2512 as an example here)

```bash
docker run -it --rm 
  -v "${HOME}":/shared \
  solids4foam/solids4foam:v2.3-openfoam-v2512 \
  bash
```

where `-v="${HOME}":/shared` means that your host computer home directory is
 mounted and shared with the container at `/shared`. The first time this command
 is executed it will download the solids4foam docker image from Docker Hub. The
 images for the other OpenFOAM variants are called

```bash
solids4foam/solids4foam:v2.3-openfoam-9
solids4foam/solids4foam:v2.3-foam-extend-4.1
```

All the images available can be found at [hub.docker.com/repository/docker/solids4foam](https://hub.docker.com/repository/docker/solids4foam/solids4foam/tags).

---

## Using solids4foam Within the Container

Once you have logged into the container, you should load OpenFOAM using the
appropriate command the version you downloaded:

```bash
source /lib/openfoam/openfoam2512/etc/bashrc            # OpenFOAM-v2512
source /opt/openfoam9/etc/bashrc                        # OpenFOAM-9
source /home/dockeruser/foam/foam-extend-4.1/etc/bashrc # foam-extend-4.1
```

You can then navigate to the solids4foam tutorials directory with the appropriate
 command below:

```bash
cd /usr/lib/solids4foam/tutorials   # OpenFOAM-v2512
cd /opt/solids4foam/tutorials       # OpenFOAM-9
cd /home/dockeruser/solids4foam     # foam-extend-4.1
```

Please see the [tutorials guide](../tutorials/README.md) to learn how to run the
tutorials.

```tip
Note: it is straightforward to install additional software in the Docker
container, e.g. `sudo apt-get install emacs`
```

```tip
Models run from within the `/shared` mounted directory will be visible from your
host computer. In that way, you can use ParaView on your host computer to view
the cases.
```

--

## Exiting the Docker Container

You can exit a container with

```bash
exit
```

Note that this will stop and remove the container.
