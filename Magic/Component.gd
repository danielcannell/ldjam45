class_name Component

var type: int  # Globals.ComponentType
var subtype: int  # Globals.Elements or Globals.Constutions


func _init(type: int, subtype: int):
    self.type = type
    self.subtype = subtype

func equals(other: Component):
    return self.type == other.type and self.subtype == other.subtype

func image():
    return Globals.COMPONENT_IMAGES[type][subtype]
