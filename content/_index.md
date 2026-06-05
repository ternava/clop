+++
title = "CLOP"
+++

**clop** counts the command-line options a program advertises in its `--help`
text. 

<!--By pointing **clop** at a program, it tells you *how many* command-line options that program has. 

It targets the one-option-per-line help layouts produced by **GNU coreutils**,
**BusyBox** and **Toybox**. -->


## Install

**clop** is a single, self-contained Bash script, with no runtime or build step. _How to install it?_

<p>
  <a class="button" href="clop" download="clop">⬇ Download clop</a>
  <a class="button secondary" href="https://github.com/ternava/clop">View on GitHub</a>
</p>

**Option 1:** After downloading, make it executable and put it on your `PATH`:

```sh
chmod +x clop
mv clop ~/.local/bin/clop      # make sure ~/.local/bin is on your PATH
```

**Option 2:** Or fetch it directly from a terminal:

```sh
curl -fsSL https://ternava.github.io/clop/clop -o clop
chmod +x clop
mv clop ~/.local/bin/clop
```

**Option 3:** From a clone of the repository you can also use the Makefile in `tool/` directory:

```sh
make -C tool install                       # installs to /usr/local/bin (may need sudo)
make -C tool PREFIX="$HOME/.local" install # install into your home directory
make -C tool uninstall                     # remove it again
```

Then, see **[Usage](@/usage.md)** for examples and output formats, and
**[Support](@/support.md)** for exactly which help sources **clop** can and cannot
read.

This is version `0.2.0`, it adds per-program version detection on top of the
first basic release.