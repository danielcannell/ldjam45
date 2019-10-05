extends Node
class_name Inventory

signal passive
signal active

var itemtype_item_map := {
	Globals.ItemType.HAT: PassiveSelfFocus.new(null, null, 0),
	Globals.ItemType.TORCH: null
}

var active_items := {
	HAT: null,
	RING1: null,
	RING2: null,
	WEAPON: null
}

var inactive_items := []

func _ready():
	connect("item_pickup", self, "_on_item_pickup")
	connect("item_activate", self, "_on_item_activate")
	connect("item_deactivate", self, "_on_item_deactivate")
	connect("item_drop", self, "_on_item_drop")

func _on_item_pickup(item_type):
	var item = itemtype_item_map[item_type].duplicate()
	if item != null:
		self.inactive_items.append(item)
	else:
		print("Invalid ItemType: %d" % item_type)
	