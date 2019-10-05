extends Node2D

const Player = preload("res://Playfield/Player.tscn")


func _init():
    var player = Player.instance()
    add_child(player)
