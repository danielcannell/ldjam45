extends Node2D


const ComponentButton := preload("res://UI/ComponentButton.gd")
const FocusButton := preload("res://UI/FocusButton.gd")


# Called when the node enters the scene tree for the first time.
func _ready():
    update_components_list()
    update_focus_list()


func update_components_list():
    var component_list := $CanvasLayer/Panel/VBoxContainer/ComponentContainer/ComponentList

    var btn := ComponentButton.new()
    component_list.add_child(btn)


func update_focus_list():
    var focus_list := $CanvasLayer/Panel/VBoxContainer/FociContainer/FociList

    var btn := FocusButton.new()
    btn.connect("button_down", $CanvasLayer/FocusEditor, "show")
    focus_list.add_child(btn)
