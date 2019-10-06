extends Node2D
class_name DamagePopup


var pos := Vector2(0,0)
var damage: float = 0.0
var offset_y: float = 48 # Screen pixels
var ttl = Config.DAMAGE_POPUP_TIME + Config.DAMAGE_POPUP_FADE_TIME

onready var roomcenter = $"../../RoomCenter"


func _init(entity: Node2D, damage: float).():
    pos = entity.position
    self.damage = damage


func _ready():
    pass


func _process(delta):
    offset_y += delta * (300 * ttl)
    ttl -= delta
    if ttl < 0:
        queue_free()
    update()


func _draw():
    # self.pos is in world coordinates.
    # undo the camera transform to place it in the right place on screen
    var render_pos := pos
    render_pos -= roomcenter.position
    render_pos /= roomcenter.camera.zoom.x
    render_pos += (get_viewport().get_visible_rect().size / 2)

    render_pos.y -= offset_y

    var alpha: float = 1
    if ttl < Config.DAMAGE_POPUP_FADE_TIME:
        alpha = ttl / Config.DAMAGE_POPUP_FADE_TIME

    var color := Color.red
    if damage < 0:
        color = Color(0, 1, 0, alpha)
    elif damage > 0:
        color = Color(1, 0, 0, alpha)
    else:
        color = Color(0, 0, 1, alpha)

    var text: String = str(int(damage))
    var str_size := Globals.damage_popup_font.get_string_size(text)
    var ascent := Globals.damage_popup_font.get_ascent()
    var str_width = str_size.x / 2
    draw_circle(render_pos, str_width + 2, color)
    draw_string(Globals.damage_popup_font, render_pos + Vector2(-str_width, ascent - str_size.y/2), text, Color(1, 1, 1, alpha))