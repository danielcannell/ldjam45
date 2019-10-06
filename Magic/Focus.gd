class_name Focus

var Actions_ = Actions.new()

var type: int     # enum Globals.FocusType
var subtype: int  # enum Globals.Foci
var element: Element = null
var power := 0.0
var active := false

func _init(type: int, subtype: int, element: Element, power: float):
    self.type = type
    self.subtype = subtype
    self.element = element
    self.power = power


func image():
    if element != null:
        if Globals.ENCHANTED_FOCUS_IMAGES.has(subtype):
            if Globals.ENCHANTED_FOCUS_IMAGES[subtype].has(element.type):
                return Globals.ENCHANTED_FOCUS_IMAGES[subtype][element.type]

    return Globals.FOCUS_IMAGES[self.subtype]


func name():
    # Generic names
    if element == null:
        return Globals.FOCUS_NAMES[subtype]

    if Globals.ENCHANTED_FOCUS_NAMES.has(subtype):
        if Globals.ENCHANTED_FOCUS_NAMES[subtype].has(element.type):
            return Globals.ENCHANTED_FOCUS_NAMES[subtype][element.type]

    return Globals.ENCHANTED_FOCUS_NAME_TEMPLATES[subtype] % element.name()


func flavour_text():
    # Generic names
    if element == null:
        return Globals.FOCUS_FLAVOUR[subtype]

    if Globals.ENCHANTED_FOCUS_FLAVOUR.has(subtype):
        if Globals.ENCHANTED_FOCUS_FLAVOUR[subtype].has(element.type):
            return Globals.ENCHANTED_FOCUS_FLAVOUR[subtype][element.type]

    return Globals.ENCHANTED_FOCUS_FLAVOUR_TEMPLATES[subtype] % element.name()


func action() -> Actions.FocusAction:
    return Actions_.by_focus[self.subtype]


func equals(other: Focus) -> bool:
    return (
        self.type == other.type
        and self.subtype == other.subtype
        and self.element.equals(other.element)
        and self.power == other.power
    )


func damage_type():
    if element == null:
        return Globals.Elements._MAX
    else:
        return element.type
