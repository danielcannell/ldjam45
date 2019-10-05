extends Node
class_name StatusEffects

var resistances := {
    "fire": 1.0,
    "water": 1.0,
    "wind": 1.0,
    "rock": 1.0, 
    "physical": 1.0 
}

var buffs := {
    "dmg_resist": 1.0,
    "speed": 1.0,
}

func compute_overall_effects(active_items):
    for item in active_items:
        pass