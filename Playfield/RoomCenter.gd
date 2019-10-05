extends Node2D


onready var playfield = find_parent("Playfield")
onready var camera = get_node("Camera2D")
var targetzoom = 1.0
var targetposition = Vector2(0, 0)
var cell_size = Vector2(16, 16)


func jump_to_room(room: Room) -> void:
    move_to_room(room)
    camera.zoom = Vector2(targetzoom, targetzoom)
    position = targetposition


func move_to_room(room: Room) -> void:
    var size := room.size()
    # Add to each dimension so walls are visible
    var width = size.x + 4
    var height = size.y + 4

    # TODO work out screen size, in cells
    var vp_rect = get_viewport().get_visible_rect()
    var screenheight = vp_rect.size.y / cell_size.y
    var screenwidth = vp_rect.size.x / cell_size.x

    var screenscale = 1.0

    # Scale so the largest dimension fits on screen
    if (screenheight / screenwidth) < (height / width):
        # screen is wider than map is tall: scale so height fits
        screenscale = height / screenheight
    else:
        # screen is taller than map is wide: scale so width fits
        screenscale = width / screenwidth

    targetzoom = screenscale
    targetposition = room.center() * cell_size.x


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
