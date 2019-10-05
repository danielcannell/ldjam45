extends KinematicBody2D


var speed = 10000
var health = 100


var action_cooldowns = []


onready var health_bar = $HealthBar


func damage(dmg):
    health -= dmg


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


func activate_item(slot):
    if action_cooldowns[slot] < 1e-6:
        print("Activate item ", slot)
        action_cooldowns[slot] = 0.5


func _init():
    for i in range(Globals.Slots._MAX):
        action_cooldowns.append(0.0)


func _ready():
    pass


func _physics_process(delta):
    var velocity = get_input()
    move_and_slide(velocity * delta)


func _process(delta):
    if Input.is_action_just_pressed("activate_item_0"):
        activate_item(0)
    if Input.is_action_just_pressed("activate_item_1"):
        activate_item(1)
    if Input.is_action_just_pressed("activate_item_2"):
        activate_item(2)
    if Input.is_action_just_pressed("activate_item_3"):
        activate_item(3)

    for i in range(Globals.Slots._MAX):
        action_cooldowns[i] = max(0, action_cooldowns[i] - delta)

    health_bar.set_value(health)
