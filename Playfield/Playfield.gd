extends Node2D


const Player = preload("res://Playfield/Entities/Player.tscn")
const Enemy = preload("res://Playfield/Entities/Enemy.tscn")
const Item = preload("res://Playfield/Entities/Item.tscn")


var enemies = []
var items = []


func _ready():
    var player = Player.instance()
    add_child(player)

    var enemy = Enemy.instance()
    add_child(enemy)
    enemies.append(enemy)

    var hat = Item.instance()
    hat.set_item_type(Globals.ItemType.HAT)
    add_child(hat)
    items.append(hat)

    var torch = Item.instance()
    torch.set_item_type(Globals.ItemType.TORCH)
    add_child(torch)
    items.append(torch)