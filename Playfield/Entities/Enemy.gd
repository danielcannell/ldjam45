extends KinematicBody2D


var health = 100


onready var health_bar = $HealthBar


func damage(dmg):
    health = max(0, health - dmg)


func _process(delta):
    health_bar.set_value(health)
