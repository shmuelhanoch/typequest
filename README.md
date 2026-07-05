# TypeQuest

A type-driven engine for terminal typing games, built in Janet.

`TypeQuest` uses structured data, strict parsing, and pure functional state transitions to model a classic dungeon crawler/exploration game directly in your terminal.

## Core Architecture

The project is structured around the principles of pure state transformation and explicit side effects, mimicking advanced effect systems in a lightweight, dynamic environment:

1. **The Grid/World (Level 1):** Pure spatial data representing the structural layout of the map.
2. **Entity Component System / State (Level 2):** Pure data models representing the Player, Enemies, Items, and Stats. Vectorized/linear updates to positions and mechanics.
3. **The Game Loop (Level 3):** A natural transformation over time. Input events are mapped to state transformations (`State -> State`) while lifting all I/O mutations out of the core logic.

---

## Prerequisites

You need to have `janet` and its package manager `jpm` installed.

* **Janet:** [Installation Guide](https://janet-lang.org/docs/index.html)

---

## How to Run

Follow these steps to clone, build, and execute TypeQuest on your machine.

### 1. Clone the Repository
```bash
git clone [https://github.com/yourusername/typequest.git](https://github.com/yourusername/typequest.git)
cd typequest


2. Build the Standalone Binary
TypeQuest can be compiled into a fast, native standalone executable using Janet's package manager:
jpm build


This will generate an executable inside the ./build/ directory.
3. Launching the Game
You can spin up the game in two ways:
Via Compiled Binary (Recommended for production/speed):
./build/typequest


Via Interpreter (Best for active development/hot-reloading):
janet main.janet


How to Play
TypeQuest is a turn-based tactical exploration game. Every action you take advances the state of the world.
Mechanics & Gameplay Loop
Exploration: You control the hero, represented by the @ symbol. Move through the grid to clear the fog of war.
Turn-Based Logic: Time only moves when you move. Plan your pathing carefully to avoid getting cornered by enemies.
Tactical Interactions: Stepping onto an enemy tile initiates a pure-functional deterministic combat resolution based on your current structural stats.
Controls
Key / Input
Action
W / Arrow Up
Move North
S / Arrow Down
Move South
A / Arrow Left
Move West
D / Arrow Right
Move East
Spacebar / Period (.)
Pass Turn (Wait)
Q / Esc
Quit Game safely (Restores terminal state)

Project Structure
├── project.janet    # Project configuration and metadata
├── main.janet       # Entry point and game loop initialization
└── src/
    ├── core.janet   # Game state types, initialization, and pure logic
    ├── input.janet  # Keyboard handling and action parsing
    └── render.janet # Terminal rendering engine (ANSI escape codes)


License
MIT License.
Now the execution steps and mechanics are front and center. Ready to dive into the core state transition function inside `src/core.janet`?



