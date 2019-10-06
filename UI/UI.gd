extends Node2D


const ElementButton := preload("res://UI/ElementButton.gd")
const FocusButton := preload("res://UI/FocusButton.gd")
onready var focus_editor = $CanvasLayer2/FocusEditor


func on_inventory_changed(elements, foci):
    update_elements_list(elements)
    update_focus_list(foci)


# Called when the node enters the scene tree for the first time.
func _ready():
    pass


func update_elements_list(elements):
    var element_list := $CanvasLayer/Panel/VBoxContainer/ElementContainer/ElementList

    for c in element_list.get_children():
        c.queue_free()

    for c in elements:
        var btn := ElementButton.new(c)
        element_list.add_child(btn)


func update_focus_list(foci):
    var focus_list := $CanvasLayer/Panel/VBoxContainer/FociContainer/FociList

    for f in focus_list.get_children():
        f.queue_free()

    for f in foci:
        var btn := FocusButton.new(f)
        btn.connect("button_down", focus_editor, "show_focus", [f])
        focus_list.add_child(btn)

    focus_editor.update_view()
