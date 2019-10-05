extends Node
class_name Inventory

var ItemsByName = preload("ItemsByName.gd").new()
var StatusEffects = preload("StatusEffects.gd").new()
var Focus = preload("Focus.gd")

signal passive
signal active

var active_foci := {
    "HAT": null,
    "RING1": null,
    "RING2": null,
    "WEAPON": null
}

var inactive_foci := []
var components := []

func _ready():
    connect("item_picked_up", self, "_on_item_pickup")
    # connect("item_activate", self, "_on_focus_activate")
    # connect("item_deactivate", self, "_on_item_deactivate")
    # connect("item_drop", self, "_on_item_drop")

func _on_item_pickup(item_type: String):
    var item = ItemsByName.world_items[item_type].duplicate()
    if item != null:
        self.inactive_foci.append(item)
        print(item_type)
    else:
        print("Invalid ItemType: %d" % item_type)

func _on_focus_activate(f: Focus):
    match f.action.mode:
        Focus.Mode.PASSIVE:
            # calculate_passives()
            emit_signal("passive", StatusEffects.resistances, StatusEffects.buffs)
        Focus.Mode.ACTIVE:
            print("s")