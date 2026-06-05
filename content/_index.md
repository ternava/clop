+++
title = "CLOP"
+++

## clop: Count Command Line OPtions

**clop** counts the command-line options a program advertises in its `--help`
text. By pointing **clop** at a program, it tells you *how many* command-line options that program has.

It targets the one-option-per-line help layouts produced by **GNU coreutils**,
**BusyBox** and **Toybox**.

<p>
  <a class="button" href="clop" download="clop">⬇ Download clop</a>
  <a class="button secondary" href="https://github.com/ternava/clop">View on GitHub</a>
</p>

## Install

`clop` is a single, self-contained Bash script — no runtime or build step.

After downloading, make it executable and put it on your `PATH`:

```sh
chmod +x clop
mv clop ~/.local/bin/clop      # make sure ~/.local/bin is on your PATH
```

Or fetch it directly from a terminal:

```sh
curl -fsSL https://ternava.github.io/clop/clop -o clop
chmod +x clop
mv clop ~/.local/bin/clop
```

From a clone of the repository you can also use the Makefile in `tool/`:

```sh
make -C tool install                         # installs to /usr/local/bin (may need sudo)
make -C tool PREFIX="$HOME/.local" install   # install into your home directory
make -C tool uninstall                       # remove it again
```

## Usage

```sh
clop ls                      # run 'ls --help' and count its options
clop ls cp mv                # several programs, plus a combined SUMMARY
clop --csv ls cp mv          # machine-readable CSV
clop --list ls               # also print the option names that were counted
ls --help | clop -           # read help text from standard input
clop -f captured-help.txt    # read help text from a saved file
```

Example output:

```
$ clop ls
ls
  version             9.1
  total options       60
  with aliases        25
  without aliases     35
  short option names  40
  long option names   45
```

## What it reports

For each program, `clop` records the program's version and prints five numbers:

| Field                | Meaning                                                       |
|----------------------|---------------------------------------------------------------|
| `version`            | The program's version, detected from `program --version`.     |
| `total options`      | Number of distinct options (one per option line in the help). |
| `with aliases`       | Options that have more than one spelling, e.g. `-a` / `--all`. |
| `without aliases`    | Options that have exactly one spelling.                       |
| `short option names` | Number of short forms counted, e.g. `-a`, `-1`.               |
| `long option names`  | Number of long forms counted, e.g. `--all`, `--block-size`.   |

Recording the version matters because the same program can document a different
number of options from one release to the next, so a count is only meaningful
next to the version it was measured against.

## Security

Naming a program makes `clop` run `program --help` (and `program --version` to
record its version), exactly as if you had typed them yourself. **Only pass
names of programs you trust.** To analyze help text without running anything,
capture it first and read it from a file or stdin:

```sh
untrusted --help > help.txt
clop -f help.txt
```

The script itself never passes your input to a shell, never uses `eval`, and
treats help text strictly as text (shell glob characters in `--help` output are
not expanded).

## Output formats

- default: a human-readable report
- `--csv`: `name,version,total,with,without,short,long`
- `--tsv`: the same columns, tab-separated
- `--no-header`: omit the header row in `--csv` / `--tsv`
- `--list`: additionally list the option names that were counted

This is version `0.2.0` — it adds per-program version detection on top of the
first tested, basic release.