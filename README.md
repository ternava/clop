# clop — Count cLi OPtions

`clop` counts the command-line options a program advertises in its `--help` text. It is to command-line options what [`cloc`](https://github.com/AlDanial/cloc) is to lines of code: it reports *how many* options a program has, total, how many have aliases, and how many short vs. long forms, for the one-option-per-line help layouts produced by GNU coreutils, BusyBox, and Toybox.

This repository is both the tool and the source of its project page at <https://ternava.github.io/clop/> (a [Zola](https://www.getzola.org/) site).

## Quick start

```sh
make install                         # install to /usr/local/bin (may need sudo)
make PREFIX="$HOME/.local" install   # or install into your home directory
clop ls                              # count the options of 'ls'
```

See the project page or run `clop --help` for full usage, output formats (`--csv`, `--tsv`, `--list`) and the counting rules.

## Repository layout

| Path                | Purpose                                                       |
|---------------------|----------------------------------------------------------------|
| `static/clop`       | The tool, a single, self-contained Bash script. Zola serves it at `/clop/clop` so the site can offer it for download. |
| `Makefile`          | `make test`, `make install`, `make uninstall`, `make lint`.   |
| `tests/`            | Test runner and fixtures with hand-counted expected results.  |
| `content/_index.md` | The landing page (download button + usage examples).          |
| `templates/`        | Zola HTML templates.                                          |
| `config.toml`       | Zola site configuration.                                      |

## Development

```sh
make test    # run the fixture tests and a smoke test against 'ls'
make lint    # run shellcheck if it is installed
```

Each `tests/fixtures/<name>.help` is a captured help text paired with a hand-counted `tests/fixtures/<name>.expected` line in `--csv --no-header` form.
Add a new `.help` / `.expected` pair to extend coverage. 

## Security

Naming a program makes `clop` run `program --help`, exactly as if you had typed it yourself, so **only pass names of programs you trust**. To analyze help text
without running anything, capture it first (`prog --help > help.txt`) and use `clop -f help.txt`. The script never passes input to a shell, never uses `eval`,
and treats help text strictly as text (glob characters are not expanded).

## License

See the `LICENSE` file.
