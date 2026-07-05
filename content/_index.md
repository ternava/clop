+++
title = "CLOP"
+++

**clop** counts the command-line options a program lists in its `--help` text,
for the one-option-per-line layouts of GNU coreutils, BusyBox, and Toybox.

## Install

**clop** is a single, self-contained Bash script. No runtime, no build step.

<p>
  <a class="button" href="clop" download="clop">⬇ Download clop</a>
  <a class="button secondary" href="https://github.com/ternava/clop">View on GitHub</a>
</p>

Download it, make it executable, and put it on your `PATH`:

```sh
chmod +x clop
mv clop ~/.local/bin/clop      # ensure ~/.local/bin is on your PATH
```

Or fetch it from the terminal:

```sh
curl -fsSL https://ternava.github.io/clop/clop -o clop
chmod +x clop
mv clop ~/.local/bin/clop
```

Or install from a clone:

```sh
make -C tool install                       # to /usr/local/bin (may need sudo)
make -C tool PREFIX="$HOME/.local" install # into ~/.local
make -C tool uninstall                     # remove it again
```

See [Usage](@/usage.md) for examples and [Support](@/support.md) for supported
help sources.

Version `0.2.0`.