extends Node
class_name AIManager

var player = null
var playfield = null
var time: float = 0
var player_room = null
var player_room_ttl = 0.25


func get_room(pos: Vector2) -> Room:
    var cx: float = pos.x / playfield.tilemap.cell_size.x
    var cy: float = pos.y / playfield.tilemap.cell_size.y
    return playfield.rooms.get_containing_room(Vector2(cx, cy))


func get_player_room() -> Room:
    if player_room_ttl < 0:
        player_room = get_room(player.position)
        player_room_ttl = 0.25
    return player_room


func _process(delta) -> void:
    time += delta
    player_room_ttl -= delta
