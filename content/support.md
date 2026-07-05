+++
title = "Support"
+++

## What **clop** reads

| Source                                     | How                                      |
|--------------------------------------------|------------------------------------------|
| Run `program --help`                       | when you name a `PROGRAM`                 |
| Read help text from a file                 | `clop -f FILE`                           |
| Read help text from standard input         | `clop -` (e.g. `prog --help \| clop -`)  |
| Detect the version via `program --version` | automatically, when you name a `PROGRAM` |

It works whenever help prints one option per line, as GNU coreutils, BusyBox,
and Toybox do.

## What it does *not* handle (yet)

These aren't read directly. Capture the text and pass it with `-f` or `-`:

- **`-h`**: clop always calls `--help`. Run `prog -h > help.txt`, then `clop -f help.txt`.
- **`--usage`, `help` subcommands, `--help-all`**: pipe instead, e.g. `git help -a | clop -`.
- **`man` pages**: not run, and the formatting isn't parsed.
- **`info` pages**: not supported.
- **Subcommand help**: only the top-level `--help` is read. Use `git commit --help | clop --name git-commit -`.
- **Wrapped or table-style entries**: options not starting a line with a dash may be miscounted.

## Security

`clop PROGRAM` runs `program --help` and `program --version`, so only pass names
you trust. To run nothing, capture the help first:

```sh
untrusted --help > help.txt
clop -f help.txt
```

Input is never passed to a shell or `eval`, and help text is treated as plain
text (no glob expansion).
