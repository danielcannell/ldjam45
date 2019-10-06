extends Node
class_name Inventory

# Slots ordered by enum Globals.FocusType
var active_foci := [null, null, null]
var inactive_foci := []
var all_foci := []

var inactive_components := []

func _on_item_pickup(item_type: int):
    var f: Focus
    match item_type:
        Globals.WorldItem.HAT:
            f = Focus.new(Globals.FocusType.HAT, item_type, null, 1.0)
        Globals.WorldItem.TORCH:
            var inner_comp = Component.new(Globals.ComponentType.ELEMENT, Globals.Elements.FIRE)
            f = Focus.new(Globals.FocusType.WEAPON, item_type, inner_comp, 1.0)
        _:
            print("Unknown WorldItem %d" % item_type)
    
    self.inactive_foci.append(f)
    self.all_foci.append(f)
