extends Node2D


const Player = preload("res://Playfield/Entities/Player.tscn")
const Enemy = preload("res://Playfield/Entities/Enemy.tscn")


var enemies = []
var rooms = []
onready var tilemap = find_node("TileMap")
onready var roomcenter = find_node("RoomCenter")

func _init():
    var player = Player.instance()
    add_child(player)

    var enemy = Enemy.instance()
    add_child(enemy)
    enemies.append(enemy)

    rooms.append(Rect2(0, 0, 9, 9))
    rooms.append(Rect2(8, 0, 11, 14))
    rooms.append(Rect2(0, 8, 11, 10))


func _ready():
    roomcenter.cell_size = tilemap.cell_size
    roomcenter.jump_to_room(rooms[0])


func _unhandled_input(event):
    if event is InputEventKey:
        if event.pressed:
            if (event.scancode == KEY_1):
                roomcenter.move_to_room(rooms[0])
            if (event.scancode == KEY_2):
                roomcenter.move_to_room(rooms[1])
            if (event.scancode == KEY_3):
                roomcenter.move_to_room(rooms[2])
