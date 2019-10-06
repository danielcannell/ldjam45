extends TextureRect


signal enchant  # Element


func can_drop_data(_pos, data):
    return data is Element


func drop_data(_pos, data):
    emit_signal("enchant", data)
