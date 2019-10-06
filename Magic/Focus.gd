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


func equals(other: Focus):
    return (
        self.type == other.type
        and self.subtype == other.subtype
        and self.action.equals(other.action)
        and self.component.equals(other.component)
        and self.power == other.power
    )