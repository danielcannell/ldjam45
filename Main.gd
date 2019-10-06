extends Node2D


onready var playfield = $ViewportContainer/Viewport/Playfield
onready var magic = $Magic
onready var focus_editor = $UI/CanvasLayer/FocusEditor
onready var ui = $UI


func _ready():
    focus_editor.connect("disenchant", magic, "_on_disenchant")
    focus_editor.connect("equip", magic, "_on_focus_equip")
    focus_editor.connect("enchant", magic, "_on_enchant")

    magic.connect("inventory_changed", ui, "on_inventory_changed")
    magic.connect("active", playfield, "on_equip_active")
    magic.connect("passive", playfield, "on_equip_passive")

    playfield.connect("item_picked_up", magic, "_on_item_pickup")
