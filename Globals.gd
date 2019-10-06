extends Node

# You can find these in the world
enum WorldItem {
    HAT,
    TORCH,

    _MAX,
}

enum FocusType {
    HAT,
    RING,
    WEAPON,

    _MAX
}

enum Foci {
    STICK,  # Hits things (Element slot)
    WAND,   # Shoots things (Element slot)
    STAFF,  # Explodes (Element slot)
    HAT,    # Enhances constitution (Constitution slot)
    RING,   # Protects (Element slot)

    _MAX,
}

enum ComponentType {
    ELEMENT,
    CONSTITUTION,

    _MAX
}

enum Elements {
    FIRE,
    WATER,
    WIND,
    ROCK,

    _MAX
}

enum Constitution {
    HEALTH,
    SPEED,

    _MAX
}

enum Dir {
    LEFT,
    RIGHT,
    UP,
    DOWN
}

enum Slots {
    HAT,
    RING1,
    RING2,
    WEAPON,

    _MAX
}

enum ActionMode {
    ACTIVE,
    PASSIVE,

    _MAX
}

enum Action {
    RESIST,
    MULTIPLIER,
    HIT,
    PROJECT,
    EXPLODE,
    PROJECT_EXPLODE,

    _MAX
}

enum Tiles {
    Wall1 = 0,
    Door1 = 16,
    Door2 = 17,

    _MAX
}

enum TutorialEvents {
    DEMO_MESSAGE_EVENT,
    DEMO_ACTION_EVENT,
}

const COMPONENT_IMAGES = {
    ComponentType.ELEMENT: {
        Elements.FIRE: preload("res://Art/components/fire.png"),
        Elements.WATER: preload("res://Art/components/water.png"),
        Elements.WIND: preload("res://Art/components/wind.png"),
        Elements.ROCK: preload("res://Art/components/rock.png"),
    },
    ComponentType.CONSTITUTION: {
        Constitution.HEALTH: preload("res://Art/fireball.png"),
        Constitution.SPEED: preload("res://Art/fireball.png"),
    },
}

const FOCUS_NAMES = {
    Foci.STICK: "Stick",
    Foci.WAND: "Wand",
    Foci.STAFF: "Staff of Explosion",
    Foci.HAT: "Hat of Enhancement",
    Foci.RING: "Ring of Protection",
}

const ENCHANTED_FOCUS_NAME_TEMPLATES = {
    Foci.STICK: "Stick of %s",
    Foci.WAND: "Wand of %s",
    Foci.STAFF: "Staff of Exploding %s",
    Foci.HAT: "Hat of %s Enhancement",
    Foci.RING: "Ring of %s Protection",
}

const ENCHANTED_FOCUS_NAMES = {
    Foci.STICK: {
        Elements.FIRE: "Torch",
        Elements.WATER: "Wet Stick",
        Elements.ROCK: "Club",
        Elements.WIND: "Flute",
    },
}

const ELEMENT_NAMES = {
    Elements.FIRE: "Fire",
    Elements.WATER: "Water",
    Elements.ROCK: "Rock",
    Elements.WIND: "Wind",
}

const CONSTITUTION_NAMES = {
    Constitution.HEALTH: "Health",
    Constitution.SPEED: "Speed",
}
