extends Node2D


onready var playfield = find_parent("Playfield")
onready var camera = get_node("Camera2D")
var targetzoom = 1.0
var targetposition = Vector2(0, 0)
var cell_size = Vector2(16, 16)


func jump_to_room(room: Rect2):
    move_to_room(room)
    camera.zoom = Vector2(targetzoom, targetzoom)
    position = targetposition


func move_to_room(room: Rect2):
    var left = room.position.x
    var top = room.position.y
    var width = room.size.x
    var height = room.size.y

    # TODO work out screen size, in cells
    var screenheight = 600 / cell_size.y
    var screenwidth = 1024 / cell_size.x

    var screenscale = 1.0

    # Scale so the largest dimension fits on screen
    if (screenheight / screenwidth) < (height / width):
        # screen is wider than map is tall: scale so height fits
        screenscale = height / screenheight
    else:
        # screen is taller than map is wide: scale so width fits
        screenscale = width / screenwidth

    targetzoom = screenscale
    targetposition = Vector2(left + width / 2, top + height / 2) * cell_size.x


func _physics_process(delta):
    var currentzoom = camera.zoom.x
    if (abs(currentzoom - targetzoom) > 0.001):
        var z = 1.0
        if (((currentzoom <= targetzoom) and (currentzoom / targetzoom > 0.99)) or
            ((currentzoom >= targetzoom) and (targetzoom / currentzoom > 0.99))):
            z = targetzoom
        else:
            z = lerp(currentzoom, targetzoom, 0.1)
        camera.zoom = Vector2(z, z)

    var currentpos = position
    if (currentpos != targetposition):
        var pos = Vector2(0, 0)
        if ((currentpos - targetposition).length() < 0.25):
            pos = targetposition
        else:
            pos = lerp(currentpos, targetposition, 0.1)
        position = pos
