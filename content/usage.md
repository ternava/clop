+++
title = "Usage"
+++

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

```console
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

For each program, **clop** records the program's version and prints five numbers:

| Field                | Meaning                                                       |
|----------------------|---------------------------------------------------------------|
| `version`            | The program's version, detected from `program --version`.     |
| `total options`      | Number of distinct options (one per option line in the help). |
| `with aliases`       | Options that have more than one spelling, e.g. `-a` / `--all`. |
| `without aliases`    | Options that have exactly one spelling.                       |
| `short option names` | Number of short forms counted, e.g. `-a`, `-1`.               |
| `long option names`  | Number of long forms counted, e.g. `--all`, `--block-size`.   |

<!-- Recording the version matters because the same program can document a different
number of options from one release to the next, so a count is only meaningful
next to the version it was measured against. -->

## Output formats

- default: a human-readable report
- `--csv`: `name,version,total,with,without,short,long`
- `--tsv`: the same columns, tab-separated
- `--no-header`: omit the header row in `--csv` / `--tsv`
- `--list`: additionally list the option names that were counted

## Labelling sources

When you read from a file or standard input, there is no program name or
version for **clop** to discover. You can supply them yourself:

```sh
clop --name busybox -f busybox.help                 # label the source
clop --name tar --prog-version 1.35 -f tar.help     # also record a version
```
