extends Area2D


const TEXTURES = {
    Globals.WorldItem.HAT: preload("res://Art/foci/hat.png"),
    Globals.WorldItem.TORCH: preload("res://Art/foci/torch.png"),
    Globals.WorldItem.WAND: preload("res://Art/foci/wand.png"),
}


var type


func set_type(t):
    type = t
    $ItemSprite.set_texture(TEXTURES[type])


func _ready():
    # This signal is emitted when a PhysicsObject2D enters this area. The
    # collision masks are set so that this will only happen when the player
    # enters
    connect("body_entered", self, "_on_body_entered")


func _on_body_entered(body):
    # The player has entered this area
    get_parent().on_item_picked_up(type)
    queue_free()
