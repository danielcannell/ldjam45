extends Area2D


var type


func set_type(t):
    type = t
    $ItemSprite.set_texture(Globals.WORLD_ITEM_IMAGES[type])


func _ready():
    # This signal is emitted when a PhysicsObject2D enters this area. The
    # collision masks are set so that this will only happen when the player
    # enters
    connect("body_entered", self, "_on_body_entered")


func _on_body_entered(body):
    # The player has entered this area
    get_parent().on_item_picked_up(type)
    queue_free()
