extends Node2D


const ComponentButton := preload("res://UI/ComponentButton.gd")
const FocusButton := preload("res://UI/FocusButton.gd")


func on_inventory_changed(components, foci):
    update_components_list(components)
    update_focus_list(foci)


# Called when the node enters the scene tree for the first time.
func _ready():
    var components := [
        Component.new(Globals.ComponentType.ELEMENT, Globals.Elements.FIRE),
        Component.new(Globals.ComponentType.ELEMENT, Globals.Elements.WATER),
        Component.new(Globals.ComponentType.ELEMENT, Globals.Elements.WIND),
        Component.new(Globals.ComponentType.ELEMENT, Globals.Elements.ROCK),
    ]

    var foci := [
        Focus.new(Globals.FocusType.HAT, Globals.Foci.HAT, Globals.Action.MULTIPLIER, null, 0.0),
        Focus.new(Globals.FocusType.WEAPON, Globals.Foci.STICK, Globals.Action.MULTIPLIER, null, 0.0),
        Focus.new(Globals.FocusType.WEAPON, Globals.Foci.STICK, Globals.Action.MULTIPLIER, components[0], 0.0),
        Focus.new(Globals.FocusType.WEAPON, Globals.Foci.WAND, Globals.Action.MULTIPLIER, components[1], 0.0),
    ]

    on_inventory_changed(components, foci)


func update_components_list(components):
    var component_list := $CanvasLayer/Panel/VBoxContainer/ComponentContainer/ComponentList

    for c in components:
        var btn := ComponentButton.new(c)
        component_list.add_child(btn)


func update_focus_list(foci):
    var focus_list := $CanvasLayer/Panel/VBoxContainer/FociContainer/FociList

    for f in foci:
        var btn := FocusButton.new(f)
        btn.connect("button_down", $CanvasLayer/FocusEditor, "show_focus", [f])
        focus_list.add_child(btn)
