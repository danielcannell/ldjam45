extends Node2D


const Player = preload("res://Playfield/Entities/Player.tscn")
const Enemy = preload("res://Playfield/Entities/Enemy.tscn")


var enemies = []


func _init():
    var player = Player.instance()
    add_child(player)

    var enemy = Enemy.instance()
    add_child(enemy)
    enemies.append(enemy)
