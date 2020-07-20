# Dockerfiles for Jutge.org


## Documentation

There are several types of images:

- `full`: includes all required dependencies.
- `lite`: includes all required dependencies, except exotic compilers.
- `server`: includes all required dependencies, except LaTeX.
- `test`: includes all required dependencies, except LaTeX and exotic compilers.

You can build the three images with `make` or just one with `make full|lite|server|test`.

If you want to install the `jutge-run` shortcut to run commands inside a container with a Jutge image, you will need to install `python3` along with the `jutge-toolkit` that can be installed with `pip3 install jutge-toolkit`. 


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

## Usage

To use the image we prepared the `jutge-run` wrapper to avoid typing several commands to just do one thing.

```
jutge-run command [ arg1 arg2 ... ]
```

``jutge-run`` wrapper lets you run the following commands:

- `jutge-make-problem`: Check the program correctness, verify if all the solutions are correct and generate the .pdf files.
- `jutge-make-quiz`: Generate the json file for a quiz based on a seed.
- `jutge-compilers`: Lists all supported compilers.
- `jutge-available-compilers`: Lists all availablecompilers.
- `jutge-submit`: Correct a Jutge.org submission just as if it was sent to the website.

### jutge-make-problem

The common scenario is to run `make-problem` in the command line within a directory containing a problem. This will generate the correct outputs for each test case input using the defined solution and will /also generate the PDF with the problem statement.

`make-problem` supports the following arguments:

- `--executable`: Makes the executables of the problems.
- `--corrects `: Generates the solution files of the problems.
- `--prints`: Creates the printable files in `.pdf` format.
- `--all` : Does everything mentioned above.
- `--recursive`: The toolkit searches recursively for problems.
- `--list`: Lists all the problems found recursively.
- `--iterations`: Choose how many times the programs will be executed in order to get a more accurate execution time.
- `--clean`: Removes all generated files (*.exe, *.cor, *.pdf).
- `--force` or `-f`: Don't prompt when removing generated files.
- `--verify`: Verify the correctness of a program.
- `--help` or `-h` : Shows a help message with available arguments.

For full details, please refer to the [common problem documentation](documentation/problems.md).

### jutge-make-quiz

In order to generate a quiz, simply execute `make-quiz` inside a directory that contains the quiz, passing as a unique parameter an integer number that will be used as the random seed. The output will be a JSON file with the generated quiz.

For full details, please refer to the [quiz problem documentation](documentation/quizzes.md).

### jutge-submit

To correct a Jutge.org submission just like [Jutge.org](https://jutge.org/) would do, run `submit` and redirect the content of the `.tar` file you want to correct to the input and redirect the output to another `.tar`file that will contain the correction results.

```
j submit < input_problem.tar > output_problem.tar
```

The input `.tar` file must have the following structure:

```
└── input_problem.tar
	├── com
	|	├── start.py
	|	└── util.py
	├── driver.tgz (may differ depending on the problem)
	├── problem.tgz (different structure possiblities, see make-problem)
	|	├── handler.yml
	|	├── problem.ca.tex
	|	├── problem.ca.yml
	|	├── problem.en.tex
	|	├── problem.en.yml
	|	├── sample.inp
	|	├── sample.cor
	|	├── tags.yml
	|	└── ...
	└── submission.tgzç
		├── solution.c (file sent by the user)
		└── submission.yml
```

The `com` folder contains the necessary files to start the problem correction. The `driver.tgz` file contains the scripts that will be in charge of correcting the problem.

`problem.tgz` is the problem solution (generated with the `make-problem` command) and `submission.tgz` is the submission that the user sent to the website along with some metadata such as the user email, the submission number, the compiler id or the problem id (stored on the file `submission.yml`).

## Credits

- [Jordi Petit](https://github.com/jordi-petit)
- [Jordi Reig](https://github.com/jordireig)


## License

Apache License 2.0
