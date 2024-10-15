# Dockerfiles for Jutge.org's images

This repository contains the code necessary to generate Docker images for the [Jutge System](https://github.com/jutge-org). These images are used in the Jutge System's workers when evaluating a problem, and are able to execute a "driver" (the program controlling how the evaluation is done), and also use different compilers to produce binaries for different languages.

The image itself has all the necessary binaries installed inside (starting from an Ubuntu system for now) and also provides isolation from the operating system as a form of security against both "bad" drivers or submissions.

In general these images are generated, locally tested, and eventually uploaded to the GitHub Container Registry (`ghcr.io`). (Take a look at the [available images](https://github.com/orgs/jutge-org/packages).)

Generated images are uploaded to the registry with a particular version number and swapped in the running workers from time to time. 

# Image interface

Images encapsulate the whole process of evaluating a submission. A program outside the image (`jutge-run` right now) launches `docker` choosing the image to run and setting several parameters: the UID of the user running inside the image; the working directory (mapped to the outside); the program that will be run inside the image (`jutge-submit` right now); and several other parameters which limit resources in the container.

The program running in the container will receive, at its standard input (`stdin`) the submission to evaluate as a `.tar` file. When decompressing this `.tar`, it has to contain exactly three `.tgz` files inside: `driver.tgz`, `problem.tgz` and `submission.tgz`. This format is universal enough to allow any type of problem.

The evaluator program running inside the container will then process the `submission.tgz` (using both the `driver.tgz` and the `problem.tgz`) and produce a `correction.tgz` file at the standard output (`stdout`). All of this happens in a folder which is inside the container and which is discarded once the docker container finishes execution.

The diagram is this:
```
                         ┌─────────────────┐                   
task.tar           │     │                 │                   
 ├─ driver.tgz     ├────►│   Jutge Image   ├───► correction.tgz
 ├─ problem.tgz    │     │                 │                   
 └─ submission.tgz │     └─────────────────┘                   
```

# Image types and building them

Right now, there are 3 different types of image, even if the most used is `server`:

| name     | BaseSystem | Compilers | LaTeX |
| -------- | ---------- | --------- | ----- |
| `lite`   | ✔          |           | ✔     |
| `server` | ✔          | ✔         |       |
| `full`   | ✔          | ✔         | ✔     |

We plan to create images for different language families in the near future.

Use `make` to build all images or `make <type>` to build only one of them. The `Dockerfile.<type>` files suggest the types available.

# Installation

Firstly, you need to have [Docker](https://docker.io) installed.

Then, the quickest way to do the setup is to clone the repository with submodules:

```sh
git clone --recurse-submodules -b new https://github.com/jutge-org/jutge-dockerfiles
```

If you already cloned the repo, you can update Git submodules with:

```sh
git submodule init
git submodule update
```

Then, just invoke `make` with the images you want (or no params for all of them)

```sh
make lite
make server
make full
make test
```

#### Old README

The old README, which documented the judging process is now at [the masterplan repository](https://github.com/jutge-org/masterplan/blob/main/docs/jutge-dockerfile.README.md).

## Credits

- [Jordi Petit](https://github.com/jordi-petit)
- [Jordi Reig](https://github.com/jordireig)
- [Pau Fernández](https://github.com/pauek)
- [Carlos Martín](https://github.com/Witixin1512)

## License

Apache License 2.0
