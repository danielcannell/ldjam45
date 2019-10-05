extends Item
class_name Component

var type: int  # enum Type

func _init(base_name: String, flavour_text: Dictionary, type: int).(base_name, flavour_text):
    self.type = type
