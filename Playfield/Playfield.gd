extends Node2D


const Player = preload("res://Playfield/Entities/Player.tscn")
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
onready var damage_popups = $DamagePopups


const DEBUG_ROOM_BOUNDS = false


func _init():
    player = Player.instance()
    player.connect("damaged", self, "on_entity_damaged")
    add_child(player)

    var font_data = DynamicFontData.new()
    font_data.font_path = "res://Art/DejaVuSansMono.ttf"
    Globals.damage_popup_font = DynamicFont.new()
    Globals.damage_popup_font.font_data = font_data
    Globals.damage_popup_font.size = 36


func add_enemy(enemy: Enemy, x: float, y: float, loot: int = Globals.WorldItem._MAX) -> void:
    enemy.loot = loot
    enemy.position = tilemap.map_to_world(Vector2(x, y))
    enemy.connect("damaged", self, "on_entity_damaged")
    add_child(enemy)


func add_item(item_type: int, x: float, y: float) -> void:
    var item = Item.instance()
    item.position = tilemap.map_to_world(Vector2(x, y))
    item.set_type(item_type)
    add_child(item)


func _ready():
    Globals.ai_manager = $AI
    Globals.ai_manager.playfield = self
    Globals.ai_manager.player = player

    rooms.compute_bounds(tilemap)
    roomcenter.cell_size = tilemap.cell_size

    var player_start := Vector2(Config.PLAYER_START_X, Config.PLAYER_START_Y)
    player.position = tilemap.map_to_world(player_start) + Vector2(0, 8)

    currentroom = rooms.get_containing_room(player_start)
    assert(currentroom != null)
    roomcenter.jump_to_room(currentroom)

    add_enemy(EnemyTypes.grunt(), 9, 1)
    add_enemy(EnemyTypes.grunt(), 13, 5)

    add_item(Globals.WorldItem.STICK, 32, 3.5)

    add_enemy(EnemyTypes.elemental_boss(), -39, -26, Globals.WorldItem.RING)
    add_item(Globals.WorldItem.WIND, -40, -27)

    add_enemy(EnemyTypes.balrog(), 24, 28)

    var world_items = [
        Globals.WorldItem.STICK,
        Globals.WorldItem.WAND,
        Globals.WorldItem.STAFF,
        Globals.WorldItem.HAT,
        Globals.WorldItem.RING,

        Globals.WorldItem.FIRE,
        Globals.WorldItem.WATER,
        Globals.WorldItem.ROCK,
        Globals.WorldItem.WIND,
    ]


func on_item_picked_up(item):
    emit_signal("item_picked_up", item)


func on_equip_active(focus):
    equipped_focus = focus


func on_equip_passive(resistances, buffs):
    player.set_passives(resistances, buffs)


func on_entity_damaged(entity: Node2D, damage: float) -> void:
    damage_popups.add_child(DamagePopup.new(entity, damage))


func swing():
    var s = Swing.instance()
    var dir: Vector2 = get_global_mouse_position() - player.position
    s.init(equipped_focus, dir)
    player.add_child(s)
    s.position = Vector2(sign(dir.x) * 4, 4)


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
            if type != Globals.Elements._MAX:
                shoot(type)
        elif action == Globals.Action.EXPLODE:
            if type != Globals.Elements._MAX:
                explode(type)
        else:
            assert(false)

func _unhandled_input(event):
    if event.is_action_pressed("activate_item_0"):
        activate_item()

func _process(delta):
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
