+++
title = "Support"
+++

## What **clop** reads

**clop** only knows two ways to obtain help text, plus one way to detect a version:

| It does                                    | How                                            |
|--------------------------------------------|------------------------------------------------|
| Run `program --help`                       | when you name a `PROGRAM` on the command line  |
| Read help text from a file                 | `clop -f FILE`                                 |
| Read help text from standard input         | `clop -` (e.g. `prog --help \| clop -`)        |
| Detect the version via `program --version` | automatically, when you name a `PROGRAM`       |

That is the whole list of what is supported by **clop**. If a program prints one option per line, i.e., the layout used by **GNU coreutils**, **BusyBox**, and **Toybox**, then **clop** counts it well.

## What **clop** does *not* support (yet)

**clop** is deliberately small, so several common "give me help" conventions are
**not** attempted:

- **`-h`**: **clop** always invokes `--help`, never the short `-h`. If a program
  only responds to `-h`, you can still capture it yourself in this way: `prog -h > help.txt; clop -f help.txt`.
- **`--usage` / `--help all` / `help` subcommands**, e.g. `git help`,
  `go help`, `--help-all`. **clop** does not support these yet. So, capture and pipe instead: 
  `git help -a | clop -`.
- **`man` pages**: **clop** does not run `man`, and man-page formatting is not the one parsed.
  <!-- one-option-per-line layout it parses. 
  A best-effort pipe sometimes works but
  is not guaranteed: `man prog | col -bx | clop -`. -->
- **`info` pages**: not supported, so treat them the same as `man` pages above.
- **Subcommand help**: **clop** reads the *top-level* `--help` only. For a
  subcommand, capture it first: `git commit --help | clop --name git-commit -`.
- **Multi-line / wrapped option entries**: options whose name does not begin a
  line with a dash (heavily indented or table-style help) may be miscounted.

In short: **clop** reliably handles **`--help`**, **`-f FILE`**, and **stdin** for
one-option-per-line layouts. Anything else, such as `-h`, `man`, `info`, subcommand
trees, or unusual formatting, is **not yet** handled directly, but you can
almost always feed it in manually with `-f` or `-`.

## Security

Naming a program makes **clop** run `program --help` (and `program --version` to
record its version), exactly as if you had typed them yourself. Therefore, **only pass
names of programs you trust.** To analyze help text without running anything,
capture it first and read it from a file or stdin:

```sh
untrusted --help > help.txt
clop -f help.txt
```

The script itself never passes your input to a shell, never uses `eval`, and
treats help text strictly as text (shell glob characters in `--help` output are
not expanded).
