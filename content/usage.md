+++
title = "Usage"
+++

```sh
clop ls                      # run 'ls --help' and count its options
clop ls cp mv                # several programs, plus a combined SUMMARY
clop --csv ls cp mv          # machine-readable CSV
clop --list ls               # also print the option names counted
ls --help | clop -           # read help from standard input
clop -f captured-help.txt    # read help from a saved file
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

| Field                | Meaning                                                   |
|----------------------|-----------------------------------------------------------|
| `version`            | Program version, from `program --version`.                |
| `total options`      | Distinct options (one per option line in the help).       |
| `with aliases`       | Options with more than one spelling, e.g. `-a` / `--all`. |
| `without aliases`    | Options with exactly one spelling.                        |
| `short option names` | Short forms, e.g. `-a`, `-1`.                             |
| `long option names`  | Long forms, e.g. `--all`, `--block-size`.                 |

The same program can list different options across releases, so a count only
means something next to its version.

## Output formats

| Flag          | Output                                        |
|---------------|-----------------------------------------------|
| *(default)*   | Human-readable report.                        |
| `--csv`       | `name,version,total,with,without,short,long`  |
| `--tsv`       | The same columns, tab-separated.              |
| `--no-header` | Omit the header row in `--csv` / `--tsv`.     |
| `--list`      | Also list the option names counted.           |

## Labelling sources

A file or stdin has no program name or version to detect, so supply them:

```sh
clop --name busybox -f busybox.help               # label the source
clop --name tar --prog-version 1.35 -f tar.help   # also record a version
```
