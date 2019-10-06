extends Node

# You can find these in the world
enum WorldItem {
    STICK,
    WAND,
    STAFF,
    HAT,
    RING,

    FIRE,
    WATER,
    ROCK,
    WIND,

    HEALTH,
    SPEED,

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

enum Team {
    PLAYER,
    ENEMY,

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
    #ComponentType.CONSTITUTION: {
    #    Constitution.HEALTH: preload("res://Art/fireball.png"),
    #    Constitution.SPEED: preload("res://Art/fireball.png"),
    #},
}

const FOCUS_IMAGES = {
    Foci.STICK: preload("res://Art/foci/stick.png"),
    Foci.WAND: preload("res://Art/foci/wand.png"),
    Foci.STAFF: preload("res://Art/foci/staff.png"),
    Foci.HAT: preload("res://Art/foci/hat.png"),
    Foci.RING: preload("res://Art/foci/ring.png"),
}

# Special cased focus images
const ENCHANTED_FOCUS_IMAGES = {
    Foci.STICK: {
        Elements.FIRE: preload("res://Art/foci/torch.png"),
    },
}

const WORLD_ITEM_IMAGES = {
    WorldItem.STICK: preload("res://Art/foci/stick.png"),
    WorldItem.WAND: preload("res://Art/foci/wand.png"),
    WorldItem.STAFF: preload("res://Art/foci/staff.png"),
    WorldItem.HAT: preload("res://Art/foci/hat.png"),
    WorldItem.RING: preload("res://Art/foci/ring.png"),

    WorldItem.FIRE: preload("res://Art/components/fire.png"),
    WorldItem.WATER: preload("res://Art/components/water.png"),
    WorldItem.ROCK: preload("res://Art/components/rock.png"),
    WorldItem.WIND: preload("res://Art/components/wind.png"),

    # WorldItem.HEALTH,
    # WorldItem.SPEED,
}

const PROJECTILE_IMAGES = {
    Elements.FIRE: preload("res://Art/projectiles/fireball.png"),
    Elements.WATER: preload("res://Art/projectiles/waterball.png"),
    Elements.ROCK: preload("res://Art/projectiles/rockball.png"),
    Elements.WIND: preload("res://Art/projectiles/windball.png"),
}

# Names of unenchanted foci
const FOCUS_NAMES = {
    Foci.STICK: "Stick",
    Foci.WAND: "Short pointy stick",
    Foci.STAFF: "Long rugged stick",
    Foci.HAT: "Floppy hat",
    Foci.RING: "Gaudy ring",
}

const FOCUS_FLAVOUR = {
    Foci.STICK: "Oblongoid of ruggedness",
    Foci.WAND: "The Elder Pooh-stick",
    Foci.STAFF: "You shall not staff",
    Foci.HAT: "Pointy",
    Foci.RING: "Not the one"
}

# Templates for formatting enchanted focus names
const ENCHANTED_FOCUS_NAME_TEMPLATES = {
    Foci.STICK: "Stick of %s",
    Foci.WAND: "Wand of %s",
    Foci.STAFF: "Staff of Exploding %s",
    Foci.HAT: "Hat of %s Enhancement",
    Foci.RING: "Ring of %s Protection",
}

const ENCHANTED_FOCUS_FLAVOUR_TEMPLATES = {
    Foci.STICK: "It's got %s on the end",
    Foci.WAND: "Shoots %sbolts with great force",
    Foci.STAFF: "Explodes with blasts of %s",
    Foci.HAT: "Boosts %s",
    Foci.RING: "You fell as if %s couldn't possible hurt you"
}

# Special cased focus names
const ENCHANTED_FOCUS_NAMES = {
    Foci.STICK: {
        Elements.FIRE: "Torch",
        Elements.WATER: "Wet Stick",
        Elements.ROCK: "Club",
        Elements.WIND: "Flute",
    },
}

# Special cased flavour text
const ENCHANTED_FOCUS_FLAVOUR = {}

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
