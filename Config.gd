extends Node

const EXPLOSION_NUM_PROJECTILES = 10
const EXPLOSION_PROJECTILE_RANGE = 50

const PLAYER_START_X = 9
const PLAYER_START_Y = 3

# If active is false, then the tutorial will not run.
# If active is true, then the tutorial will run. Simples!
var tutorial_active = true

# Tutorial events we've already seen
var tutorial_occurred = []