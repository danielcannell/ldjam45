class_name Focus

var type: int     # enum Globals.FocusType
var subtype: int  # enum Globals.Foci
var action: Action
var component: Component = null
var power := 0.0


func _init(type: int, subtype: int, action: Action, component: Component, power: float):
    self.type = type
    self.subtype = subtype
    self.action = action
    self.component = component
    self.power = power


func image():
    pass

func equals(other: Focus):
    return (
        self.type == other.type
        and self.subtype == other.subtype
        and self.action.equals(other.action)
        and self.component.equals(other.component)
        and self.power == other.power
    )