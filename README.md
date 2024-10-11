# Dockerfiles for Jutge.org's workers

You need to have [Docker](https://docker.io) installed.

There are 3 different images you can compile using the same Dockerfile:

| name     | BaseSystem | Compilers | LaTeX |
| -------- | ---------- | --------- | ----- |
| `lite`   | ✔          |           | ✔     |
| `server` | ✔          | ✔         |       |
| `full`   | ✔          | ✔         | ✔     |

Use `make` to build all images or `make full|lite|server` to build only one of them.

## Building manually

This image has two optional build arguments: `type` and `vinga`

- `type` may be one of `lite`, `server` or `full`. Defaults to server
- `vinga` may be one of `compile-vinga` or `download-vinga` to compile vinga from the source or to download it if you do not have access to the source. Defaults to compile-vinga

You may pass build arguments to the docker build process using `--build-arg type=server` or `--build-arg vinga=download-vinga`.

## Usage

Starting the correction process requires from the host machine works best with `jutge-run` from [Jutge  Server Toolkit](https://github.com/jutge-org/jutge-server-toolkit)

For more information on how to create and acquire the required files for a correction, check out the problem
documentation on [Jutge Toolkit](https://github.com/jutge-org/jutge-toolkit/blob/master/README.md)

## Credits

- [Jordi Petit](https://github.com/jordi-petit)
- [Jordi Reig](https://github.com/jordireig)
- [Pau Fernández](https://github.com/pauek)

## License

Apache License 2.0
