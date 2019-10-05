extends Node2D


const Player = preload("res://Playfield/Entities/Player.tscn")
const Enemy = preload("res://Playfield/Entities/Enemy.tscn")
const Item = preload("res://Playfield/Entities/Item.tscn")
const Projectile = preload("res://Playfield/Entities/Projectile.tscn")


signal item_picked_up

var player
var enemies = []
var rooms = []

var item_cooldown = 0

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
    hat.set_type(Globals.WorldItem.HAT)
    add_child(hat)

    var torch = Item.instance()
    torch.position = tilemap.map_to_world(Vector2(10, 10))
    torch.set_type(Globals.WorldItem.TORCH)
    add_child(torch)


func on_item_picked_up(item):
    emit_signal("item_picked_up", item)


func shoot():
    var p = Projectile.instance()
    p.init(Globals.Elements.FIRE, player.position, get_global_mouse_position(), 1e6)
    add_child(p)


func explode():
    for i in range(Config.EXPLOSION_NUM_PROJECTILES):
        var theta = (i * 6.283185307) / Config.EXPLOSION_NUM_PROJECTILES
        var target = player.position + Vector2(cos(theta), sin(theta))
        var p = Projectile.instance()
        p.init(Globals.Elements.FIRE, player.position, target, Config.EXPLOSION_PROJECTILE_RANGE)
        add_child(p)


func activate_item():
    if item_cooldown < 1e-6:
        item_cooldown = 0.25

        # shoot()
        explode()


func _process(delta):
    # For now we just have one active item slot
    if Input.is_action_just_pressed("activate_item_0"):
        activate_item()

    item_cooldown = max(0, item_cooldown - delta)
