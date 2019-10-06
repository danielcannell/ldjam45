extends Area2D

var focus
var velocity: float = 0
var team = Globals.Team.PLAYER
var ttl: float = 0
var hits: Array = []

# Angular speed, deg/s
const SPEED: float = 600.0
const SWING_ANGLE: float = 90.0


func init(focus, direction: Vector2):
    self.focus = focus
    velocity = deg2rad(SPEED)
    rotation = direction.angle() + deg2rad(90 - (SWING_ANGLE / 2))

    var sprite := $ItemSprite
    sprite.set_texture(focus.image())
    ttl = SWING_ANGLE / SPEED


func _ready():
    # This signal is emitted when a PhysicsObject2D enters this area. The
    # collision masks are set so that this will happen if we hit an enemy or a
    # wall
    connect("body_entered", self, "_on_body_entered")


func _physics_process(delta):
    ttl -= delta

    # Swing time
    if ttl > 0:
        var angle_delta = velocity * delta
        rotation += angle_delta

    # Hang around a bit at the end of the swing
    if ttl < -0.15:
        queue_free()


func _on_body_entered(body):
    if body.has_method("get_team"):
        if body.get_team() == team:
            return

    if body.has_method("damage") and not hits.has(body):
        # We have collided with an enemy!
        body.damage(10)
        hits.append(body)
