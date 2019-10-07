extends Node
class_name Inventory


signal tutorial_event


# Slots ordered by enum Globals.FocusType
var active_foci := [null, null, null]
var inactive_foci := []
var all_foci := []

var inactive_elements := []


func pickup_focus(type, subtype):
    emit_signal("tutorial_event", Globals.TutorialEvents.FOCUS_PICKUP)

    var power = 1.0
    if type == Globals.FocusType.RING:
        power = 0.0
    elif type == Globals.FocusType.HAT:
        power = 2.0

    var f := Focus.new(type, subtype, null, power)
    self.inactive_foci.append(f)
    self.all_foci.append(f)


func pickup_element(type):
    emit_signal("tutorial_event", Globals.TutorialEvents.ELEMENT_PICKUP)

    inactive_elements.append(Element.new(type))


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
            pickup_element(Globals.Elements.FIRE)
        Globals.WorldItem.WATER:
            pickup_element(Globals.Elements.WATER)
        Globals.WorldItem.ROCK:
            pickup_element(Globals.Elements.ROCK)
        Globals.WorldItem.WIND:
            pickup_element(Globals.Elements.WIND)
