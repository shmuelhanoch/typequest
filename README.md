# TypeQuest ⌨️

A minimalist terminal typing coach designed for speed and focus.

## Prerequisites

Ensure you have your environment ready via Nix or standard system tools.

```bash
# Enter the development environment (handles compilers, Janet, and JPM)
nix develop

Quick Start

Run the application directly using the just automation runner:
Bash

# Fetch and compile C dependencies
just deps

# Launch the game instantly via the interpreter
just run

Building from Source

To compile the codebase down to a highly optimized, standalone native binary:
Bash

# Build the production executable
just build

# Execute the compiled binary
./build/typequest
