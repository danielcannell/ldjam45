extends Node2D


const Player = preload("res://Playfield/Entities/Player.tscn")
const Enemy = preload("res://Playfield/Entities/Enemy.tscn")
const Item = preload("res://Playfield/Entities/Item.tscn")

signal item_picked_up

var player
var enemies = []
var rooms = []
onready var tilemap = find_node("TileMap")
onready var roomcenter = find_node("RoomCenter")


func _init():
    player = Player.instance()
    add_child(player)

    rooms.append(Rect2(0, 0, 9, 9))
    rooms.append(Rect2(8, 0, 11, 14))
    rooms.append(Rect2(0, 8, 11, 10))


func _ready():
    roomcenter.cell_size = tilemap.cell_size
    roomcenter.jump_to_room(rooms[0])

    player.position = tilemap.map_to_world(Vector2(2, 2))

    var enemy = Enemy.instance()
    enemy.position = tilemap.map_to_world(Vector2(6, 2))
    add_child(enemy)
    enemies.append(enemy)

    var hat = Item.instance()
    hat.position = tilemap.map_to_world(Vector2(5, 5))
    hat.set_item_type(Globals.WorldItem.HAT)
    add_child(hat)

    var torch = Item.instance()
    torch.position = tilemap.map_to_world(Vector2(10, 10))
    torch.set_item_type(Globals.WorldItem.TORCH)
    add_child(torch)


func _unhandled_input(event):
    if event is InputEventKey:
        if event.pressed:
            if (event.scancode == KEY_1):
                roomcenter.move_to_room(rooms[0])
            if (event.scancode == KEY_2):
                roomcenter.move_to_room(rooms[1])
            if (event.scancode == KEY_3):
                roomcenter.move_to_room(rooms[2])


func on_item_picked_up(item):
    emit_signal("item_picked_up", item)
    player.damage(50)
