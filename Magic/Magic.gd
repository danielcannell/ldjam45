extends Node

var Inventory = preload("Inventory.gd")

var inventory = Inventory.new()

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func get_active_components():
    var active_components = []
    for focus in self.inventory.active_foci.values():
        if focus != null and focus.component != null:
            active_components.append(focus.component)
    return active_components

func _on_item_pickup(item_type: int):
    return self.inventory._on_item_pickup(item_type)