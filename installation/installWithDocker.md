---
sort: 2
---

# Installing solids4foam with Docker

---

## What is Docker?

[Docker](https://www.docker.com) is an open source software platform for creating, deploying and managing virtualized application *containers*. Using docker we can essentialy create a light-weight virtual machine with solids4foam and its dependencies already installed.

---

## How do I Install Docker?

Docker can be installed on Windows, macOS and Linux by following the instructions on the [Docker website](https://docs.docker.com/get-docker/).

---

## Downloading the solids4foam Docker Image

Once docker is installed, open a terminal on Linux or macOS or PowerShell on Windows; the solids4foam docker image can be downloaded from Docker Hub with one of commands below depending on which version of OpenFOAM or foam you would like
```
> docker pull solids4foam/solids4foam-v2.0-openfoam-v2012
> docker pull solids4foam/solids4foam-v2.0-openfoam-9
> docker pull solids4foam/solids4foam-v2.0-foam-extend-4.1
```
The image is ~6.2 GB.

---

## Creating the solids4foam Docker Container

In macOS and Linux, the solids4foam container can be created with
```
> docker create --entrypoint /bin/bash -v="${HOME}":/shared \
       --name solids4foam-v2.0-openfoam-v2012 \
       -it solids4foam/solids4foam-v2.0-openfoam-v2012
```
where `-v="${HOME}":/shared` means that your host computer home directory is mounted and shared with the container at `/shared`. The name of the image and container should be updated to use the version that you downloaded.

In Windows PowerShell, the command becomes:
```
> docker create --entrypoint /bin/bash -v="${HOME}":/shared \
       \--name solids4foam-v2.0-openfoam-v2012 \
       -it solids4foam/solids4foam-v2.0-openfoam-v2012
```
where `--name` has become `\--name`.

---

## Starting and Attaching to the solids4foam Docker Container

You can now attach to the created container with
```
> docker start solids4foam-v2.0-openfoam-v2012
```
and subsequently connect to it with
```
> docker attach solids4foam-v2.0-openfoam-v2012
```

---
## Using solids4foam Within the Container

Once you have logged into the container, you can navigate to the solids4foam tutorials directory with
```
> cd $WM_PROJECT_DIR/../solids4foam/tutorials
```
Please see the [tutorials guide](../tutorials/README.md) to learn how to run the tutorials.

```tip
Note: it is straightforward to install additional software in the Docker container, e.g. `sudo apt-get install emacs`
```

```tip
Models run from within the `/shared' mounted directory will be visible from your host computer. In that way, you can use ParaView on your host computer to view the cases.
```

--
## Exiting the Docker Container

You can exit a container with
```
> exit
```
Note that this will stop the container. You can re-start the container and re-attach to it with the commands given above.
