# Dockerfiles for Jurge.org

## Documentation

There are three types of images:

- `full`: includes all required dependencies.
- `lite`: includes all required dependencies, except exotic compilers.
- `server`: includes all required dependencies, except LaTeX.

You can build the three images with `make` or just one with `make full|lite|server`.

If you want to install the `j` shortcut to run commands from the container, use `make install`.


## Dependencies

You need to have `docker` installed.


## Credits

- [Jordi Petit](https://github.com/jordi-petit)
- [Jordi Reig](https://github.com/jordireig)


## License

Apache License 2.0
