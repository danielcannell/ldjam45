extends TextureRect


signal enchant  # Component


func can_drop_data(_pos, data):
    return data is Component


func drop_data(_pos, data):
    emit_signal("enchant", data)
