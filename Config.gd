extends Node

const EXPLOSION_NUM_PROJECTILES = 10
const EXPLOSION_PROJECTILE_RANGE = 50

const PLAYER_START_X = 9
const PLAYER_START_Y = 3

const PLAYER_SPEED = 100
const HEAL_RATE = 10
const DAMAGE_REDUCTION_FACTOR = 1
const SPEED_BOOST_FACTOR = 1

var player_resistances := {
    Globals.Elements.FIRE: 1.0,
    Globals.Elements.WATER: 1.0,
    Globals.Elements.WIND: 1.0,
    Globals.Elements.ROCK: 1.0
}

var player_buffs := {
    Globals.Elements.FIRE: 1.0,
    Globals.Elements.WATER: 1.0,
    Globals.Elements.WIND: 1.0,
    Globals.Elements.ROCK: 1.0
}

# If active is false, then the tutorial will not run.
# If active is true, then the tutorial will run. Simples!
var tutorial_active = true
var tutorial_on_restart = true
# Tutorial events we've already seen
var tutorial_occurred = []
