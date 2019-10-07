class_name EnemyTypes

const EnemyScene = preload("res://Playfield/Entities/Enemy.tscn")

static func grunt(speed: float = 32.0) -> Enemy:
    var enemy = EnemyScene.instance()
    var aggro_distance: float = 64.0
    var lose_sight_distance: float = 96.0
    var attack_range: float = 16.0

    enemy.add_ai(AICharge.new(Globals.ai_manager, enemy, aggro_distance, lose_sight_distance, attack_range))
    enemy.add_ai(AIWander.new(Globals.ai_manager, enemy, 1, 5, 8))

    enemy.movement_speed = speed
    enemy.image = Globals.ENEMY_IMAGES["grunt"]
    enemy.sprite_width = 14.0
    enemy.sprite_height = 20.0
    var rock: Element = Element.new(Globals.Elements.ROCK)
    enemy.weapon = Focus.new(Globals.FocusType.WEAPON, Globals.Foci.STICK, rock, 1.0)
    enemy.weapon.power = 0.1
    enemy.set_max_health(20)
    return enemy


static func evil_wizard(elem: int = Globals.Elements.FIRE) -> Enemy:
    var enemy = EnemyScene.instance()
    var aggro_distance: float = 64.0
    var lose_sight_distance: float = 128.0
    var attack_range: float = 64.0
    var keep_away_distance: float = 32.0

    var spellcaster := AISpellcaster.new(Globals.ai_manager, enemy, aggro_distance, lose_sight_distance, attack_range, keep_away_distance)
    spellcaster.only_one_room = false
    enemy.add_ai(spellcaster)
    enemy.add_ai(AIWander.new(Globals.ai_manager, enemy, 1, 5, 8))

    enemy.movement_speed = 100.0
    enemy.image = Globals.ENEMY_IMAGES["evil_wizard"]
    enemy.sprite_width = 14.0
    enemy.sprite_height = 22.0
    var type: Element = Element.new(elem)
    enemy.weapon = Focus.new(Globals.FocusType.WEAPON, Globals.Foci.WAND, type, 1.0)
    return enemy


static func fire_elemental() -> Enemy:
    var enemy = EnemyScene.instance()
    var aggro_distance: float = 64.0
    var lose_sight_distance: float = 128.0
    var attack_range: float = 40.0
    var keep_away_distance: float = 0.0

    enemy.add_ai(AISpellcaster.new(Globals.ai_manager, enemy, aggro_distance, lose_sight_distance, attack_range, keep_away_distance))
    enemy.add_ai(AIGoHome.new(Globals.ai_manager, enemy))

    enemy.set_passives([Globals.Elements.FIRE], [Globals.Elements.WATER], [])

    enemy.movement_speed = 10.0
    enemy.image = Globals.ENEMY_IMAGES["fire_elemental"]
    enemy.sprite_width = 17.0
    enemy.sprite_height = 40.0
    var type: Element = Element.new(Globals.Elements.FIRE)
    enemy.weapon = Focus.new(Globals.FocusType.WEAPON, Globals.Foci.STAFF, type, 1.0)
    return enemy


static func water_elemental() -> Enemy:
    var enemy = EnemyScene.instance()
    var aggro_distance: float = 64.0
    var lose_sight_distance: float = 128.0
    var attack_range: float = 40.0
    var keep_away_distance: float = 0.0

    enemy.add_ai(AISpellcaster.new(Globals.ai_manager, enemy, aggro_distance, lose_sight_distance, attack_range, keep_away_distance))
    enemy.add_ai(AIGoHome.new(Globals.ai_manager, enemy))

    enemy.set_passives([Globals.Elements.WATER], [Globals.Elements.WIND], [])

    enemy.movement_speed = 10.0
    enemy.image = Globals.ENEMY_IMAGES["water_elemental"]
    enemy.sprite_width = 32.0
    enemy.sprite_height = 40.0
    var type: Element = Element.new(Globals.Elements.WATER)
    enemy.weapon = Focus.new(Globals.FocusType.WEAPON, Globals.Foci.STAFF, type, 1.0)
    return enemy


static func elemental_boss() -> Enemy:
    var enemy = EnemyScene.instance()
    var aggro_distance: float = 999.0
    var lose_sight_distance: float = 999.0
    var attack_range: float = 128.0
    var keep_away_distance: float = 0.0

    enemy.add_ai(AISpellcaster.new(Globals.ai_manager, enemy, aggro_distance, lose_sight_distance, attack_range, keep_away_distance))
    enemy.add_ai(AIGoHome.new(Globals.ai_manager, enemy))

    enemy.set_passives([], [Globals.Elements.FIRE, Globals.Elements.WATER], [])

    enemy.movement_speed = 32.0
    enemy.image = Globals.ENEMY_IMAGES["elemental_boss"]
    enemy.sprite_width = 64.0
    enemy.sprite_height = 80.0
    var type: Element = Element.new(Globals.Elements.WIND)
    enemy.weapon = Focus.new(Globals.FocusType.WEAPON, Globals.Foci.STAFF, type, 1.5)

    enemy.explode_count = 15
    enemy.explode_range = 200.0
    enemy.attack_cooldown = 1.5

    return enemy


static func balrog() -> Enemy:
    var enemy = EnemyScene.instance()
    var aggro_distance: float = 999999.0
    var lose_sight_distance: float = 999999.0
    var attack_range: float = 999999.0
    var keep_away_distance: float = 0.0

    enemy.add_ai(AISpellcaster.new(Globals.ai_manager, enemy, aggro_distance, lose_sight_distance, attack_range, keep_away_distance))
    enemy.add_ai(AIGoHome.new(Globals.ai_manager, enemy))

    enemy.set_passives([Globals.Elements.FIRE, Globals.Elements.WATER], [], [])

    enemy.movement_speed = 2.0
    enemy.image = Globals.ENEMY_IMAGES["balrog"]
    enemy.sprite_width = 192.0
    enemy.sprite_height = 200.0
    var type: Element = Element.new(Globals.Elements.FIRE)
    enemy.weapon = Focus.new(Globals.FocusType.WEAPON, Globals.Foci.STAFF, type, 5.0)

    enemy.set_max_health(500)

    enemy.explode_count = 30
    enemy.explode_range = 1e6
    enemy.attack_cooldown = 1.0

    return enemy
