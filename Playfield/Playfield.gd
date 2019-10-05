extends Node2D


const Player = preload("res://Playfield/Entities/Player.tscn")
const Enemy = preload("res://Playfield/Entities/Enemy.tscn")
const Item = preload("res://Playfield/Entities/Item.tscn")


var enemies = []
var items = []
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

    var hat = Item.instance()
    hat.set_item_type(Globals.ItemType.HAT)
    add_child(hat)
    items.append(hat)

    var torch = Item.instance()
    torch.set_item_type(Globals.ItemType.TORCH)
    add_child(torch)
    items.append(torch)


func _unhandled_input(event):
    if event is InputEventKey:
        if event.pressed:
            if (event.scancode == KEY_1):
                roomcenter.move_to_room(rooms[0])
            if (event.scancode == KEY_2):
                roomcenter.move_to_room(rooms[1])
            if (event.scancode == KEY_3):
                roomcenter.move_to_room(rooms[2])
