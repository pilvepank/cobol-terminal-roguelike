# COBOL Terminal Roguelike & Dungeon Crawler

A fully featured, turn-based ASCII dungeon crawler game written from scratch in pure COBOL-85 / COBOL 2002.

## Key Features
* **Procedural Map Carving**: Rectangular room sculpting, boundary walls, and bidirectional corridor tunneling.
* **Raycasting Field of View (FOV)**: 16-ray circular shadowcasting out to radius 5, implementing Fog of War (Visible, Seen/Remembered, and Unseen).
* **Turn-Based AI State Machine**: Monsters feature autonomous state transitions:
  * `Patrol ('P')`: Ambient roaming.
  * `Aggro ('A')`: Detects player within 6 tiles and pathfinds via Manhattan distance.
  * `Flee ('F')`: Retracts when HP drops below critical thresholds.
* **Hierarchical RPG Inventory**: Weapons, Armor, and Potions modeled with idiomatic COBOL hierarchical levels (`01 PLAYER-RECORD`, `05 P-STATS`, `10 INV-ITEM`).
* **Turn Simulation & ANSI Text Buffer**: Real-time 20x60 character matrix screen buffer with real-time HUD and event log.

## Building and Running
```cmd
build.bat
run.bat
```


## Arcane Magic Subsystem
* **Fireball & Heal**: Area-of-effect spells with mana deduction.
* **Savegame Persistence**: Binary serialization of dungeon state.


## Extended Roguelike Subsystems
* **Arcane Magic Engine**: Mana pools, Fireball, and Heal spells.
* **Inventory Management**: Bag capacity, potion application, and equipment slots.
* **Game State Persistence**: Binary serialization of dungeon state.


## Extended Roguelike Subsystems
* **Arcane Magic Engine**: Mana pools, Fireball, and Heal spells.
* **Inventory Management**: Bag capacity, potion application, and equipment slots.
* **Game State Persistence**: Binary serialization of dungeon state.


## Extended Roguelike Subsystems
* **Arcane Magic Engine**: Mana pools, Fireball, and Heal spells.
* **Inventory Management**: Bag capacity, potion application, and equipment slots.
* **Game State Persistence**: Binary serialization of dungeon state.


## Extended Roguelike Subsystems
* **Arcane Magic Engine**: Mana pools, Fireball, and Heal spells.
* **Inventory Management**: Bag capacity, potion application, and equipment slots.
* **Game State Persistence**: Binary serialization of dungeon state.


## Extended Roguelike Subsystems
* **Arcane Magic Engine**: Mana pools, Fireball, and Heal spells.
* **Inventory Management**: Bag capacity, potion application, and equipment slots.
* **Game State Persistence**: Binary serialization of dungeon state.
