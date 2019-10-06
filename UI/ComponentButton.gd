extends TextureButton


var component


func _init(c: Component):
    component = c
    texture_normal = component.image()
    expand = true
    stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
    rect_min_size = Vector2(50, 50)


func get_drag_data(_pos):
    # Use another colorpicker as drag preview
    var btn = TextureButton.new()
    btn.texture_normal = texture_normal
    btn.rect_size = Vector2(50, 50)
    btn.expand = true
    set_drag_preview(btn)
    return component