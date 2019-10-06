class_name Comparators

static func component(a: Component, b: Component) -> bool:
    if a.type < b.type:
        return true
    elif a.subtype < b.subtype:
        return true
    else:
        return false
        
static func focus(a: Focus, b: Focus) -> bool:
    if a.type < b.type:
        return true
    elif a.subtype < b.subtype:
        return true
    else:
        return false
