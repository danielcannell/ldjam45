extends Area2D


const Enemy = preload("res://Playfield/Entities/Enemy.tscn")


const TEXTURES = {
    Globals.Elements.FIRE: preload("res://Art/fireball.png"),
}


var type
var velocity = Vector2(200, 0)
var ttl = 10000

const SPEED = 200


func init(t, pos, target, range_):
    type = t
    position = pos
    velocity = (target - pos).normalized() * SPEED
    ttl = range_

    var sprite := $ProjectileSprite
    sprite.set_texture(TEXTURES[type])
    sprite.set_rotation(velocity.angle())


func _ready():
    # This signal is emitted when a PhysicsObject2D enters this area. The
    # collision masks are set so that this will happen if we hit an enemy or a
    # wall
    connect("body_entered", self, "_on_body_entered")


func _physics_process(delta):
    var pos_delta = velocity * delta
    position += pos_delta

    ttl -= pos_delta.length()
    if ttl < 0:
        queue_free()


func _on_body_entered(body):
    queue_free()

    if body.has_method("damage"):
        # We have collided with an enemy!
        body.damage(10)
