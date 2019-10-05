extends KinematicBody2D


var speed = 200


func get_input():
    var velocity = Vector2()

    if Input.is_action_pressed("player_up"):
        velocity.y -= 1
    if Input.is_action_pressed("player_down"):
        velocity.y += 1
    if Input.is_action_pressed("player_left"):
        velocity.x -= 1
    if Input.is_action_pressed("player_right"):
        velocity.x += 1

    return velocity.normalized() * speed


func _ready():
    pass


func _physics_process(delta):
    var velocity = get_input()
    move_and_slide(velocity)
