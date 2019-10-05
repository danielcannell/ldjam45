extends Area2D


const TEXTURES = {
    Globals.ItemType.HAT: preload("res://Art/hat.png"),
    Globals.ItemType.TORCH: preload("res://Art/torch.png"),
}


onready var sprite = get_node("./Sprite")


var type = Globals.ItemType.NONE


func set_item_type(t):
    type = t
    # sprite.set_texture(TEXTURES[type])
