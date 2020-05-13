# Dockerfiles for Jurge.org

> Much better documentation should be provided!


## Documentation

There are several types of images:

- `full`: includes all required dependencies.
- `lite`: includes all required dependencies, except exotic compilers.
- `server`: includes all required dependencies, except LaTeX.
- `test`: includes all required dependencies, except LaTeX and exotic compilers.

You can build the three images with `make` or just one with `make full|lite|server|test`.

If you want to install the `jutge-run` shortcut to run commands inside a container with a Jutge image, use
`sudo make install`. This will also install `jutge-submit` and `jutge-start` which are handy for testing, but insecure for non trusted code.


## Dependencies

You need to have `docker` installed.


## Flow

This picture tries to summarize the flow of execution of the different components:

```
host                                                          | container
--------------------------------------------------------------|-------------------------
jutge-run jutge-submit name < sub.tar > cor.tgz 2> err.txt    |
                                                              | jutge-submit
                                                              |     jutge-start
                                                              |         jutge-driver-*
                                                              |             jutge-vinga
```


## Credits

- [Jordi Petit](https://github.com/jordi-petit)
- [Jordi Reig](https://github.com/jordireig)


## License

Apache License 2.0
