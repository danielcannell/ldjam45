extends Node2D


const ComponentButton := preload("res://UI/ComponentButton.gd")
const FocusButton := preload("res://UI/FocusButton.gd")
onready var focus_editor = $CanvasLayer2/FocusEditor


func on_inventory_changed(components, foci):
    update_components_list(components)
    update_focus_list(foci)


# Called when the node enters the scene tree for the first time.
func _ready():
    pass


func update_components_list(components):
    var component_list := $CanvasLayer/Panel/VBoxContainer/ComponentContainer/ComponentList

    for c in component_list.get_children():
        c.queue_free()

    for c in components:
        var btn := ComponentButton.new(c)
        component_list.add_child(btn)


func update_focus_list(foci):
    var focus_list := $CanvasLayer/Panel/VBoxContainer/FociContainer/FociList

    for f in focus_list.get_children():
        f.queue_free()

    for f in foci:
        var btn := FocusButton.new(f)
        btn.connect("button_down", focus_editor, "show_focus", [f])
        focus_list.add_child(btn)

    focus_editor.update_view()
