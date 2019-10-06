extends TextureButton


const icon = preload("res://Art/hat.png")


func _init():
    texture_normal = icon
    expand = true
    stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
    rect_min_size = Vector2(50, 50)
