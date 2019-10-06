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
    if component != null:
        if Globals.ENCHANTED_FOCUS_IMAGES.has(subtype):
            if Globals.ENCHANTED_FOCUS_IMAGES[subtype].has(component.subtype):
                return Globals.ENCHANTED_FOCUS_IMAGES[subtype][component.subtype]

    return Globals.FOCUS_IMAGES[self.subtype]


func name():
    # Generic names
    if component == null:
        return Globals.FOCUS_NAMES[subtype]

    if Globals.ENCHANTED_FOCUS_NAMES.has(subtype):
        if Globals.ENCHANTED_FOCUS_NAMES[subtype].has(component.subtype):
            return Globals.ENCHANTED_FOCUS_NAMES[subtype][component.subtype]

    return Globals.ENCHANTED_FOCUS_NAME_TEMPLATES[subtype] % component.name()


func flavour_text():
    return "Test flavour text"


func action() -> Actions.FocusAction:
    return Actions_.by_focus[self.subtype]

func equals(other: Focus) -> bool:
    return (
        self.type == other.type
        and self.subtype == other.subtype
        and self.component.equals(other.component)
        and self.power == other.power
    )