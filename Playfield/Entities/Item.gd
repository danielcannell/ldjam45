extends Area2D


const TEXTURES = {
    Globals.ItemType.HAT: preload("res://Art/hat.png"),
    Globals.ItemType.TORCH: preload("res://Art/torch.png"),
}


var type = Globals.ItemType.NONE


func set_item_type(t):
    var sprite = get_node("ItemSprite")

    type = t
    sprite.set_texture(TEXTURES[type])


func _ready():
    # This signal is emitted when a PhysicsObject2D enters this area. The
    # collision masks are set so that this will only happen when the player
    # enters
    connect("body_entered", self, "_on_body_entered")


func _on_body_entered(body):
    # The player has entered this area
    get_parent().on_item_picked_up(type)
    queue_free()
