class_name Comparators

static func element(a: Element, b: Element) -> bool:
    return a.type < b.type

static func focus(a: Focus, b: Focus) -> bool:
    if a.type < b.type:
        return true
    elif a.subtype < b.subtype:
        return true
    else:
        return false
