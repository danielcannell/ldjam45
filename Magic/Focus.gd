class_name Focus

var Actions_ = Actions.new()

var type: int     # enum Globals.FocusType
var subtype: int  # enum Globals.Foci
var component: Component = null
var power := 0.0
var active := false

func _init(type: int, subtype: int, component: Component, power: float):
    self.type = type
    self.subtype = subtype
    self.component = component
    self.power = power


func image():
    pass

func action() -> Actions.FocusAction:
    return Actions_.by_focus[self.subtype]

func equals(other: Focus) -> bool:
    return (
        self.type == other.type
        and self.subtype == other.subtype
        and self.component.equals(other.component)
        and self.power == other.power
    )