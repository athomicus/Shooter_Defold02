# Shooter_Defold02 Script Connections

This document explains how the scripts in the Shooter_Defold02 project are connected and interact with each other.

## Diagram

```
spawn_enemy.script
        ↓
    enemy.script
        ↔
game_manager.script
```

## Script Descriptions

- **spawn_enemy.script:** Responsible for spawning enemies at random positions. It maintains a list of active enemies and handles their removal when necessary.
- **enemy.script:** Manages individual enemy behavior, such as movement and interactions with the player.
- **game_manager.script:** Oversees the overall game logic, including player interactions, score tracking, and game state management. It communicates with both `spawn_enemy.script` and `enemy.script`.

## Object Creation and Messaging

### Object Creation
- `spawn_enemy.script` uses a factory to create enemy objects at random positions.
- Each enemy object is added to a list for tracking purposes.

### Message Sending
- `spawn_enemy.script` sends messages to `enemy.script` to initialize enemy behavior.
- `enemy.script` sends messages to `game_manager.script` when certain events occur, such as when an enemy is destroyed.
- `game_manager.script` sends messages to `spawn_enemy.script` to control spawning behavior (e.g., stopping spawns).

### Message Receiving
- `spawn_enemy.script` receives messages from `game_manager.script` to adjust spawning logic.
- `enemy.script` receives initialization messages from `spawn_enemy.script`.
- `game_manager.script` receives event messages from `enemy.script` to update the game state.
