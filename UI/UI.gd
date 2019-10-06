extends Node2D


const ElementButton := preload("res://UI/ElementButton.gd")
const FocusButton := preload("res://UI/FocusButton.gd")
onready var focus_editor = $CanvasLayer2/FocusEditor

onready var death_popup = $CanvasLayer3/PopupPanel
onready var dp_tutorial_check = $CanvasLayer3/PopupPanel/Panel/VBoxContainer/CheckBox
onready var dp_restart_button = $CanvasLayer3/PopupPanel/Panel/VBoxContainer/HBoxContainer/RestartButton
onready var dp_exit_button = $CanvasLayer3/PopupPanel/Panel/VBoxContainer/HBoxContainer/ExitButton

func _ready():
    call_deferred("prepare_death_popup")

func on_inventory_changed(elements, foci):
    update_elements_list(elements)
    update_focus_list(foci)


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

func quit_game():
    get_tree().quit()

func restart_game():
    Config.tutorial_on_restart = dp_tutorial_check.pressed
    Config.tutorial_active = dp_tutorial_check.pressed
    get_tree().reload_current_scene()

func prepare_death_popup():
    dp_exit_button.connect("button_up", self, "quit_game")
    dp_restart_button.connect("button_up", self, "restart_game")
    dp_tutorial_check.pressed = Config.tutorial_on_restart

func on_player_death():
    death_popup.visible = true