extends Node
class_name Inventory

# Hack to have public static 
var ActionsByName = preload("ActionsByName.gd").new()
var StatusEffects = preload("StatusEffects.gd").new()

signal passive
signal active

var active_foci := {
    "HAT": null,
    "RING1": null,
    "RING2": null,
    "WEAPON": null
}

var inactive_foci := []

var active_components := []

var inactive_components := []

func _on_item_pickup(item_type: int):
    match item_type:
        Globals.WorldItem.HAT:
            inactive_foci.append(Focus.new(Globals.FocusType.HAT, item_type, ActionsByName.MULTIPLIER, null, 1.0))
        Globals.WorldItem.TORCH:
            var inner_comp = Component.new(Globals.ComponentType.ELEMENT, Globals.Elements.FIRE)
            inactive_foci.append(Focus.new(Globals.FocusType.WEAPON, item_type, ActionsByName.HIT, inner_comp, 1.0))
        _:
            print("Unknown WorldItem %d" % item_type)

func _on_focus_equip(f: Focus):
    match f.type:
        Globals.FocusType.HAT:
            inactive_foci.append(active_foci.HAT)
            active_foci.HAT = f
        Globals.FocusType.RING:
            pass