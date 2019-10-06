extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
    var playfield = $ViewportContainer/Viewport/Playfield
    var inventory = $Magic # Inventory script on Magic node
    playfield.connect("item_picked_up", inventory, "_on_item_pickup")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
