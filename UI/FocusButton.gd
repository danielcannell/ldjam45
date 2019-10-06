extends TextureButton


func _init(focus: Focus):
    texture_normal = focus.image()
    expand = true
    stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
    rect_min_size = Vector2(50, 50)
