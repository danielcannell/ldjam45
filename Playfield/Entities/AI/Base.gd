class_name AIBase

var manager: AIManager = null
var entity: Node2D = null

func _init(_manager: AIManager, _entity: Node2D):
    manager = _manager
    entity = _entity


func player_pos() -> Vector2:
    return manager.player.position


func get_pos() -> Vector2:
    return entity.position


func get_nearby_player(dist: float):
    if manager.player:
        if (player_pos() - get_pos()).abs().length() < dist:
            return manager.player
    return null


func get_random_pos_in_room(room: Room) -> Vector2:
    var bounds := room.get_bounds()
    var topleft := bounds.position
    var size := bounds.size

    var ox = randf() * size.x
    var oy = randf() * size.y

    # Cell to world
    var wx = (topleft.x + ox) * manager.playfield.tilemap.cell_size.x
    var wy = (topleft.y + oy) * manager.playfield.tilemap.cell_size.y

    return Vector2(wx, wy)


# Return a possible goal
func think():
    pass


# This AI is not providing the currently active goal
func go_idle():
    pass
