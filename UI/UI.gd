extends Node2D


const ComponentButton := preload("res://UI/ComponentButton.gd")
const FocusButton := preload("res://UI/FocusButton.gd")


var components := [
    Component.new(Globals.ComponentType.ELEMENT, Globals.Elements.FIRE),
    Component.new(Globals.ComponentType.ELEMENT, Globals.Elements.WATER),
]


# Called when the node enters the scene tree for the first time.
func _ready():
    update_components_list()
    update_focus_list()


func update_components_list():
    var component_list := $CanvasLayer/Panel/VBoxContainer/ComponentContainer/ComponentList

    for c in components:
        var btn := ComponentButton.new(c)
        component_list.add_child(btn)


func update_focus_list():
    var focus_list := $CanvasLayer/Panel/VBoxContainer/FociContainer/FociList

    var btn := FocusButton.new()
    btn.connect("button_down", $CanvasLayer/FocusEditor, "show")
    focus_list.add_child(btn)
