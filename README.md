# TypeQuest ⌨️

A type-driven engine for terminal typing games, built in Janet.

## Quick Start

This project uses [`Nix`](https://nixos.org/) to manage dependencies and build tools automatically.

### To run using `Nix`:

```bash
# 1. Enter the development environment
nix develop

# 2. Install local C dependencies (jermbox, etc)
jpm deps

# 3. Launch the game instantly via the interpreter
jpm run dev
```

### Without `Nix`

Install `Janet` manually [using your OS specific way](https://janet-lang.org/docs/index.html).
