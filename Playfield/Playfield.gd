extends Node2D


const Player = preload("res://Playfield/Entities/Player.tscn")
const Enemy = preload("res://Playfield/Entities/Enemy.tscn")
const Item = preload("res://Playfield/Entities/Item.tscn")
const Projectile = preload("res://Playfield/Entities/Projectile.tscn")
const Swing = preload("res://Playfield/Entities/Swing.tscn")


signal item_picked_up
signal tutorial_event

var player
var enemies = []
var rooms = RoomBounds.new()
var currentroom: Room = null
var equipped_focus = null

var item_cooldown = 0

onready var tilemap = find_node("TileMap")
onready var roomcenter = find_node("RoomCenter")
onready var ai_manager = $AI


const DEBUG_ROOM_BOUNDS = false


func _init():
    player = Player.instance()
    add_child(player)


func _ready():
    ai_manager.playfield = self
    ai_manager.player = player

    rooms.compute_bounds(tilemap)
    roomcenter.cell_size = tilemap.cell_size

    var player_start := Vector2(Config.PLAYER_START_X, Config.PLAYER_START_Y)
    player.position = tilemap.map_to_world(player_start)

    currentroom = rooms.get_containing_room(player_start)
    assert(currentroom != null)
    roomcenter.jump_to_room(currentroom)

    var enemy = Enemy.instance()
    enemy.position = tilemap.map_to_world(Vector2(3, 3))
    #enemy.add_ai(AICharge.new(ai_manager, enemy, 32, 64, 16))
    enemy.add_ai(AISpellcaster.new(ai_manager, enemy, 64, 128, 64, 32))
    enemy.add_ai(AIWander.new(ai_manager, enemy, 1, 5, 8))
    add_child(enemy)

    var hat = Item.instance()
    hat.position = tilemap.map_to_world(Vector2(5, 5))
    hat.set_type(Globals.WorldItem.HAT)
    add_child(hat)

    var torch = Item.instance()
    torch.position = tilemap.map_to_world(Vector2(10, 10))
    torch.set_type(Globals.WorldItem.TORCH)
    add_child(torch)

    var wand = Item.instance()
    wand.position = tilemap.map_to_world(Vector2(11, 10))
    wand.set_type(Globals.WorldItem.WAND)
    add_child(wand)


func on_item_picked_up(item):
    emit_signal("item_picked_up", item)
    emit_signal("tutorial_event", Globals.TutorialEvents.DEMO_MESSAGE_EVENT)


func on_equip_active(focus):
    equipped_focus = focus


func on_equip_passive(resistances, buffs):
    pass


func swing():
    var s = Swing.instance()
    s.init(equipped_focus, get_global_mouse_position() - player.position)
    player.add_child(s)


func shoot(type):
    var p = Projectile.instance()
    p.init(type, player.position, get_global_mouse_position(), 1e6)
    add_child(p)


func explode(type):
    for i in range(Config.EXPLOSION_NUM_PROJECTILES):
        var theta = (i * 6.283185307) / Config.EXPLOSION_NUM_PROJECTILES
        var target = player.position + Vector2(cos(theta), sin(theta))
        var p = Projectile.instance()
        p.init(type, player.position, target, Config.EXPLOSION_PROJECTILE_RANGE)
        add_child(p)


func activate_item():
    if item_cooldown < 1e-6 and equipped_focus:
        item_cooldown = 0.25

        var action = equipped_focus.action().action
        var type = equipped_focus.damage_type()
        if action == Globals.Action.HIT:
            swing()
        elif action == Globals.Action.PROJECT:
            assert(type != Globals.Elements._MAX)
            shoot(type)
        elif action == Globals.Action.EXPLODE:
            assert(type != Globals.Elements._MAX)
            explode(type)
        else:
            assert(false)


func _process(delta):
    # For now we just have one active item slot
    if Input.is_action_just_pressed("activate_item_0"):
        activate_item()

    item_cooldown = max(0, item_cooldown - delta)

    var playerroom: Room = rooms.get_containing_room(tilemap.world_to_map(player.position))
    if playerroom != null:
        currentroom = playerroom
        roomcenter.move_to_room(playerroom)

    if DEBUG_ROOM_BOUNDS:
        update()


func _draw():
    if DEBUG_ROOM_BOUNDS:
        var colors = [Color.red, Color.blue, Color.green, Color.yellow, Color.orange, Color.purple, Color.aqua, Color.darkcyan, Color.darkgreen, Color.lightblue]
        for i in range(rooms.rooms.size()):
            var points := PoolVector2Array()
            var room: Room = rooms.rooms[i]
            var zoom: float = tilemap.cell_size.x
            for point in room.points:
                points.append(point * zoom)
            points.append(room.points[0] * zoom)
            draw_polyline(points, colors[i])
