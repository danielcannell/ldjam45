extends Node
class_name Inventory

# Slots ordered by enum Globals.FocusType
var active_foci := [null, null, null]
var inactive_foci := []
var all_foci := []

var inactive_components := []


func pickup_focus(type, subtype):
    var power = 1.0
    if type == Globals.FocusType.HAT:
        power = 0.0

    var f := Focus.new(type, subtype, null, power)
    self.inactive_foci.append(f)
    self.all_foci.append(f)


func pickup_component(type, subtype):
    var c := Component.new(type, subtype)
    inactive_components.append(c)


func _on_item_pickup(item_type: int):
    var f: Focus
    match item_type:
        Globals.WorldItem.STICK:
            pickup_focus(Globals.FocusType.WEAPON, Globals.Foci.STICK)
        Globals.WorldItem.WAND:
            pickup_focus(Globals.FocusType.WEAPON, Globals.Foci.WAND)
        Globals.WorldItem.STAFF:
            pickup_focus(Globals.FocusType.WEAPON, Globals.Foci.STAFF)
        Globals.WorldItem.HAT:
            pickup_focus(Globals.FocusType.HAT, Globals.Foci.HAT)
        Globals.WorldItem.RING:
            pickup_focus(Globals.FocusType.RING, Globals.Foci.RING)

        Globals.WorldItem.FIRE:
            pickup_component(Globals.ComponentType.ELEMENT, Globals.Elements.FIRE)
        Globals.WorldItem.WATER:
            pickup_component(Globals.ComponentType.ELEMENT, Globals.Elements.WATER)
        Globals.WorldItem.ROCK:
            pickup_component(Globals.ComponentType.ELEMENT, Globals.Elements.ROCK)
        Globals.WorldItem.WIND:
            pickup_component(Globals.ComponentType.ELEMENT, Globals.Elements.WIND)

        #Globals.WorldItem.HEALTH,
        #Globals.WorldItem.SPEED,
