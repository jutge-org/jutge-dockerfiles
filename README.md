# Dockerfiles for Jutge.org's images

This repository contains the code necessary to generate Docker images for the [Jutge System](https://github.com/jutge-org). These images are used in the Jutge System's workers when evaluating a problem, and are able to execute a "driver" (the program controlling how the evaluation is done), and also use different compilers to evaluate solutions written in different programming languages.

These images are generated, tested locally, and eventually uploaded to Docker Hub. They can be seen [here](https://hub.docker.com/u/jutgeorg).

# Image types

Currently, the following images exist:

- `base` - The base image. Contains the programs used in the correction process as well as Python. The other images extend from `base`.
- `cpp` - Contains C and C++ compilers.
- `python` - Contains common Python Libs and Codon.
- `java` - Contains JVM based languages.
- `haskell` - Contains Haskell.
- `extra` - Contains other less used but popular languages.
- `esoteric` - Contains rare languages.
- `tools` - Contains utilities used by the Jutge.org service ocasionally, such as `LaTeX`.
- `circuits` - Contains the required programs in order to grade Verilog problems.

## Building

Use `make` to build all images or `make <type>` to build only one of them. The `Dockerfile.<type>` files suggest the types available.

For example, to only build the java image:

```sh
make Dockerfile.java
```

## Pulling from Docker Hub

For example, for the python image:

```sh
docker pull jutgeorg/python
```

# Image interface

Images encapsulate the whole process of evaluating a submission. A program outside the image (`jutge-run` right now) launches `docker` choosing the image to run and setting several parameters: the UID of the user running inside the image; the working directory (mapped to the outside); the program that will be run inside the image (`jutge-submit` right now); and several other parameters which limit resources in the container.

The program running in the container will receive, at its standard input (`stdin`) the submission to evaluate as a `.tar` file. When decompressing this `.tar`, it has to contain exactly three `.tgz` files inside: `driver.tgz`, `problem.tgz` and `submission.tgz`. This format is universal enough to allow any type of problem.

The evaluator program running inside the container will then process the `submission.tgz` (using both the `driver.tgz` and the `problem.tgz`) and produce a `correction.tgz` file at the standard output (`stdout`). All of this happens in a folder which is inside the container and which is discarded once the docker container finishes execution. The run log is written to `stderr`.

The diagram is this:
```
                         ┌─────────────────┐                   
task.tar           │     │                 │                   
 ├─ driver.tgz     ├───►│   Jutge Image   ├───► correction.tgz
 ├─ problem.tgz    │     │                 │            
 └─ submission.tgz │     └─────────────────┘                   
```

# Installation

Firstly, you need to have [Docker](https://docker.io) installed.

Then, the quickest way to do the setup is to clone the repository with submodules:

```sh
git clone --recurse-submodules https://github.com/jutge-org/jutge-dockerfiles
```

If you already cloned the repo, you can update Git submodules with:

```sh
git submodule init
git submodule update
```

Then, just invoke `make` with the images you want (or no params for all of them)

```sh
make
make cpp
make python
make java
make haskell
make esoteric
make tools
make extra
make circuits
```

## Credits

- [Jordi Petit](https://github.com/jordi-petit)
- [Jordi Reig](https://github.com/jordireig)
- [Pau Fernández](https://github.com/pauek)

## License

Apache License 2.0
