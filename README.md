# Dockerfiles to produce docker images

There are three types of images:

- `full`: includes all required dependencies
- `lite`: includes all required dependencies, except exotic compilers
- `server`: includes all required dependencies, except LaTeX

You can build the three images with `make` or just one with `make full`.

If you want to install the `j` shortcut to run commands from the container, use `make install`.
