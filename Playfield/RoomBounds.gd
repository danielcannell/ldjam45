class_name RoomBounds


const UNVISITED: int = -2
const WALL: int = -1

const INVALID_VEC: Vector2 = Vector2(-999, -999)
const INVALID_CELL: int = -999


var rooms = []
var bounds: Rect2
var cells: Array = []

func _init():
    if false:
        cells = []
        cells.append([-1, 0, 0, 0, 0, -1, -1, 0, 0])
        cells.append([-1, 0, 0, 0, 0, -1, -1, 0, 0])
        cells.append([-1, -1, 0, 0, 0, 0, 0, 0, 0])
        cells.append([-1, -1, 0, 0, 0, 0, 0, 0, 0])
        cells.append([0, 0, 0, 0, 0, -1, -1, -1, -1])
        cells.append([0, 0, 0, 0, 0, -1, 0, -1, -1])
        cells.append([0, 0, 0, -1, 0, 0, 0, -1, -1])

        var start := find_first_room_cell(0)
        assert(start == Vector2(1,0))
        var room := compute_bounding_polygon(start)
        assert(room.points.size() == 22)
        assert(room.points[0] == Vector2(5,0))
        assert(room.points[-1] == Vector2(1,0))

        assert(room.contains(Vector2(3, 1)))
        assert(room.size() == Vector2(9, 7))


# Get the value of a cell.
# Return INVALID_CELL if the coordinates are out of bounds.
func get_cell(x: int, y: int) -> int:
    if x < 0 or x >= cells[0].size() or y < 0 or y >= cells.size():
        return INVALID_CELL
    return cells[y][x]


# Set the value of a cell.
func set_cell(x: int, y: int, val: int) -> void:
    cells[y][x] = val


# Return true if this tile acts as a room boundary
func tile_is_boundary(tile: int) -> bool:
    if tile == Globals.Tiles.Wall1 or tile == Globals.Tiles.Door1 or tile == Globals.Tiles.Door2:
        return true
    return false


# Fill all cells connected to the start cell with num.
func flood_fill(pos: Vector2, num: int) -> void:
    if pos.x < 0 or pos.x >= cells[0].size() or pos.y < 0 or pos.y >= cells.size():
        return
    var cell := get_cell(int(pos.x), int(pos.y))
    if cell == WALL or cell == num:
        return

    set_cell(int(pos.x), int(pos.y), num)

    flood_fill(Vector2(pos.x+1, pos.y), num)
    flood_fill(Vector2(pos.x-1, pos.y), num)
    flood_fill(Vector2(pos.x, pos.y+1), num)
    flood_fill(Vector2(pos.x, pos.y-1), num)


# Find the next unvisted cell in the grid, by going right then down from start.
# Return INVALID_VEC if no unvisited cells remain.
func get_next_unvisited(start: Vector2) -> Vector2:
    var y: int = int(start.y)
    var x: int = int(start.x)
    while y < cells.size():
        while x < cells[0].size():
            if get_cell(x, y) == UNVISITED:
                return Vector2(x, y)
            x += 1
        y += 1
        x = 0

    return INVALID_VEC


# Find the top-most, left-most cell of the numbered room.
# Return INVALID_VEC if no such cell exists.
func find_first_room_cell(roomnum: int) -> Vector2:
    var y := 0
    var x := 0
    while y < cells.size():
        while x < cells[0].size():
            var cell := get_cell(x, y)
            if cell == roomnum:
                return Vector2(x, y)
            x += 1
        y += 1
        x = 0

    return INVALID_VEC


# Compute the bounding polygon for a connected room starting at pos.
func compute_bounding_polygon(start: Vector2) -> Room:
    var dir = Globals.Dir.RIGHT
    var room: Room = Room.new()
    var cx: int = int(start.x)
    var cy: int = int(start.y)
    var num: int = get_cell(cx, cy)
    assert(num >= 0)

    while true:
        if dir == Globals.Dir.RIGHT:
            # Walking along top edge
            if get_cell(cx, cy-1) == num:
                # Now go UP
                dir = Globals.Dir.UP
                room.add_point(Vector2(cx, cy))
            elif get_cell(cx, cy) != num:
                # Now go DOWN
                dir = Globals.Dir.DOWN
                room.add_point(Vector2(cx, cy))
            elif get_cell(cx, cy) == num:
                # Keep going RIGHT
                cx += 1
            else:
                assert(false)
        elif dir == Globals.Dir.DOWN:
            # Walking along right edge
            if get_cell(cx, cy) == num:
                # Now go RIGHT
                dir = Globals.Dir.RIGHT
                room.add_point(Vector2(cx, cy))
            elif get_cell(cx-1, cy) != num:
                # Now go LEFT
                dir = Globals.Dir.LEFT
                room.add_point(Vector2(cx, cy))
            elif get_cell(cx-1, cy) == num:
                # Keep going DOWN
                cy += 1
            else:
                assert(false)
        elif dir == Globals.Dir.UP:
            # Walking along left edge
            if get_cell(cx-1, cy-1) == num:
                # Now go LEFT
                dir = Globals.Dir.LEFT
                room.add_point(Vector2(cx, cy))
            elif get_cell(cx, cy-1) != num:
                # Now go RIGHT
                dir = Globals.Dir.RIGHT
                room.add_point(Vector2(cx, cy))
                if cx == int(start.x) and cy == int(start.y):
                    # Special case if we've ended up back at the start!
                    break
            elif get_cell(cx, cy-1) == num:
                # Keep going UP
                cy -= 1
            else:
                assert(false)
        elif dir == Globals.Dir.LEFT:
            # Walking along bottom edge
            if get_cell(cx-1, cy) == num:
                # Now go DOWN
                dir = Globals.Dir.DOWN
                room.add_point(Vector2(cx, cy))
            elif get_cell(cx-1, cy-1) != num:
                # Now go UP
                dir = Globals.Dir.UP
                room.add_point(Vector2(cx, cy))
            elif get_cell(cx-1, cy-1) == num:
                # Keep going LEFT
                cx -= 1
            else:
                assert(false)

    return room


# Compute all the rooms in the tilemap.
# Return number of rooms
func compute_bounds(tilemap: TileMap) -> int:
    # Initialise the grid
    bounds = tilemap.get_used_rect()
    cells = []
    for y in range(bounds.size.y):
        cells.append([])
        for x in range(bounds.size.x):
            var tile = tilemap.get_cell(int(bounds.position.x) + x, int(bounds.position.y) + y)
            if tile_is_boundary(tile):
                cells[y].append(WALL)
            else:
                cells[y].append(UNVISITED)

    # Flood fill
    var start := get_next_unvisited(Vector2(0,0))
    var num_rooms := 0
    while start != INVALID_VEC:
        flood_fill(start, num_rooms)
        num_rooms += 1
        start = get_next_unvisited(start)

    # Compute bounding polygons for each room
    rooms = []
    for i in range(num_rooms):
        var cell := find_first_room_cell(i)
        assert(cell != INVALID_VEC)
        rooms.append(compute_bounding_polygon(cell))

    return num_rooms


# Return the room which contains the point pos.
func get_containing_room(pos: Vector2) -> Room:
    for room in rooms:
        if room.contains(pos):
            return room
    return null
