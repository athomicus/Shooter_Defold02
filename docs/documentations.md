# Shooter_Defold02 Comprehensive Documentation

This document provides a detailed explanation of the scripts, their functions, and how they interact in the Shooter_Defold02 project.

---

## Overview

The Shooter_Defold02 project consists of three main scripts:
1. **spawn_enemy.script** - Handles enemy spawning and tracking.
2. **enemy.script** - Manages individual enemy behavior.
3. **game_manager.script** - Oversees the overall game logic and state.

These scripts communicate with each other using message-passing, a core feature of the Defold engine.

---

## Script Details

### 1. `spawn_enemy.script`

#### Purpose:
- Spawns enemies at random positions.
- Tracks active enemies in a list.
- Stops spawning when a maximum limit is reached.

#### Key Functions:
- **`init(self)`**:
  - Initializes the script, sets up the enemy factory, and starts a timer to spawn enemies periodically.
- **`spawn_enemy(self)`**:
  - Creates an enemy at a random position using the factory.
  - Adds the enemy to the `list_of_enemies`.
  - Stops spawning if the maximum number of enemies is reached.
- **`on_message(self, message_id, message, sender)`**:
  - Handles messages to remove enemies from the list when they are destroyed.
- **Helper Function:**
  - `is_empty(list)`:
    - Checks if the `list_of_enemies` is empty.

#### Message Interaction:
- **Sends Messages:**
  - Sends initialization messages to spawned enemies.
- **Receives Messages:**
  - Receives `remove_enemy_id` messages to remove enemies from the list.

---

### 2. `enemy.script`

#### Purpose:
- Manages individual enemy behavior, such as movement and interactions with the player.

#### Key Functions:
- **`init(self)`**:
  - Initializes the enemy's behavior and properties.
- **`update(self, dt)`**:
  - Updates the enemy's position or state each frame.
- **`on_message(self, message_id, message, sender)`**:
  - Handles messages related to enemy-specific events, such as being destroyed.

#### Message Interaction:
- **Sends Messages:**
  - Sends destruction messages to `game_manager.script` when the enemy is destroyed.
- **Receives Messages:**
  - Receives initialization messages from `spawn_enemy.script`.

---

### 3. `game_manager.script`

#### Purpose:
- Manages the overall game state, including player interactions, score tracking, and game flow.

#### Key Functions:
- **`init(self)`**:
  - Initializes the game state and sets up necessary components.
- **`on_message(self, message_id, message, sender)`**:
  - Handles messages from `enemy.script` and `spawn_enemy.script` to update the game state.
- **`update(self, dt)`**:
  - Updates the game logic each frame.

#### Message Interaction:
- **Sends Messages:**
  - Sends control messages to `spawn_enemy.script` to adjust spawning behavior.
- **Receives Messages:**
  - Receives event messages from `enemy.script` to update the score or game state.

---

## Object Creation and Messaging

### Object Creation
- `spawn_enemy.script` uses a factory to create enemy objects at random positions.
- Each enemy object is added to a list for tracking purposes.

### Message Flow
1. **From `spawn_enemy.script` to `enemy.script`:**
   - Sends initialization messages to configure enemy behavior.
2. **From `enemy.script` to `game_manager.script`:**
   - Sends destruction messages when an enemy is destroyed.
3. **From `game_manager.script` to `spawn_enemy.script`:**
   - Sends control messages to stop or adjust enemy spawning.

---

## Diagram

```
spawn_enemy.script
        ↓
    enemy.script
        ↔
game_manager.script
```

---

## Code Snippets

### Example: Spawning an Enemy
```lua
-- spawn_enemy.script
function spawn_enemy(self)
    if self.spawned_enemy_number >= max_spawn_number then
        return
    end
    self.spawned_enemy_number = self.spawned_enemy_number + 1
    local pos = vmath.vector3(math.random(60, 300), math.random(350, 550), 0)
    local e = factory.create(self.enemy_factory, pos)
    table.insert(list_of_enemies, e)
end
```

### Example: Removing an Enemy
```lua
-- spawn_enemy.script
function on_message(self, message_id, message, sender)
    if message_id == hash("remove_enemy_id") then
        for i, enemy in ipairs(list_of_enemies) do
            if enemy == message.enemy_id then
                table.remove(list_of_enemies, i)
                break
            end
        end
    end
end
```

---

## Conclusion

This documentation provides a comprehensive overview of the Shooter_Defold02 project. It explains the purpose and functionality of each script, their interactions, and the overall message flow. For further details, refer to the codebase or contact the project maintainer.
