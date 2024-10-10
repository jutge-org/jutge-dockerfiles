# Dockerfiles for Jutge.org's workers

You need to have [Docker](https://docker.io) installed.

There are 3 different images:

| name     | BaseSystem | Compilers | LaTeX |
| -------- | ---------- | --------- | ----- |
| `lite`   | ✔          |           | ✔     |
| `server` | ✔          | ✔         |       |
| `full`   | ✔          | ✔         | ✔     |

Use `make` to build all images or `make full|lite|server` to build only one of them.

#### Old README

The old README, which documented the judging process is now at [the masterplan repository](https://github.com/jutge-org/masterplan/blob/main/docs/jutge-dockerfile.README.md).


## Credits

- [Jordi Petit](https://github.com/jordi-petit)
- [Jordi Reig](https://github.com/jordireig)
- [Pau Fernández](https://github.com/pauek)
- [Carlos Martín](https://github.com/Witixin1512)

## License

Apache License 2.0
