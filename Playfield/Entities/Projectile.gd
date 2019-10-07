extends Area2D


var type
var velocity = Vector2(200, 0)
var ttl = 10000
var team = Globals.Team.PLAYER

const SPEED = 200


func init(t, pos, target, range_):
    type = t
    position = pos
    velocity = (target - pos).normalized() * SPEED
    ttl = range_

    var sprite := $ProjectileSprite
    sprite.set_texture(Globals.PROJECTILE_IMAGES[type])
    sprite.set_rotation(velocity.angle())


func _ready():
    # This signal is emitted when a PhysicsObject2D enters this area. The
    # collision masks are set so that this will happen if we hit an enemy or a
    # wall
    connect("body_entered", self, "_on_body_entered")
    
    # This signal is emitted when an area enters the area. This is for
    # collisions with other projectiles.
    connect("area_entered", self, "_on_projectile_collision")


func _on_projectile_collision(area: Area2D):
    if area.has_method("_on_projectile_collision"):
        if Globals.ELEMENT_CANCELLATION[type].has(area.type):
            queue_free()


func _physics_process(delta):
    var pos_delta = velocity * delta
    position += pos_delta

    ttl -= pos_delta.length()
    if ttl < 0:
        queue_free()


func _on_body_entered(body):
    if body.has_method("get_team"):
        if body.get_team() == team:
            return

    queue_free()

    if body.has_method("damage"):
        # We have collided with an enemy!
        # We use call_deferred because otherwise we sometimes get the following error:
        # ERROR: Can't change this state while flushing queries.
        body.call_deferred("damage", 10, type)
