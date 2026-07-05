# clop (count CLi OPtions)

`clop` counts the command-line options a program lists in its `--help` text.

Like [`cloc`](https://github.com/AlDanial/cloc), but for interfaces instead of code: it reports how many options a program has (total, aliased, short, long) from the one-option-per-line help layouts of GNU coreutils, BusyBox, and Toybox.

The repo also builds the project page at <https://ternava.github.io/clop/> with [Zola](https://www.getzola.org/).

## Quick start

```sh
make -C tool install                       # install to /usr/local/bin (may need sudo)
make -C tool PREFIX="$HOME/.local" install # or install into ~/.local
clop ls                                    # count the options of 'ls'
```

Run `clop --help` for all flags and output formats.

## Layout

| Path            | Purpose                                                      |
|-----------------|-------------------------------------------------------------|
| `tool/clop`     | The tool: a single, self-contained Bash script.             |
| `tool/Makefile` | `make test`, `make install`, `make uninstall`, `make lint`. |
| `tool/tests/`   | Test runner and fixtures with hand-counted results.         |
| `content/`      | Site pages (landing, usage, support).                       |
| `templates/`    | Zola HTML templates.                                        |
| `config.toml`   | Zola site configuration.                                    |

## Development

```sh
make -C tool test    # fixture tests plus a smoke test against 'ls'
make -C tool lint    # shellcheck, if installed
```

Each `tool/tests/fixtures/<name>.help` is captured help text paired with a hand-counted `<name>.expected` line in `--csv --no-header` form. Add a `.help` / `.expected` pair to extend coverage.

## Security

`clop PROGRAM` runs `program --help`, so only pass names you trust. To avoid running anything, capture the help first:

```sh
prog --help > help.txt
clop -f help.txt
```

Input is never passed to a shell or `eval`, and help text is treated as plain text (no glob expansion).

## License

See `LICENSE`.
