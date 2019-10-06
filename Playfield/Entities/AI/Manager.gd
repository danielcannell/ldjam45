extends Node
class_name AIManager

var player = null
var playfield = null
var time: float = 0


func get_room(pos: Vector2) -> Room:
    var cx: float = pos.x / playfield.tilemap.cell_size.x
    var cy: float = pos.y / playfield.tilemap.cell_size.y
    return playfield.rooms.get_containing_room(Vector2(cx, cy))


func _process(delta) -> void:
    time += delta
