extends Node2D


const ComponentButton := preload("res://UI/ComponentButton.gd")


# Called when the node enters the scene tree for the first time.
func _ready():
    update_components_list()


func make_component_widget():
    pass


func update_components_list():
    var component_list := $CanvasLayer/Panel/VBoxContainer/ScrollContainer/ComponentList

    var btn := ComponentButton.new()
    component_list.add_child(btn)
