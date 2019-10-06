class_name Element

var type: int  # Globals.Elements


func _init(type: int):
    self.type = type

func equals(other: Element):
    return self.type == other.type

func image():
    return Globals.ELEMENT_IMAGES[type]

func name():
    return Globals.ELEMENT_NAMES[type]
