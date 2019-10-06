class_name EnemyTypes

const EnemyScene = preload("res://Playfield/Entities/Enemy.tscn")

static func grunt() -> Enemy:
    var enemy = EnemyScene.instance()
    var aggro_distance: float = 32.0
    var lose_sight_distance: float = 64.0
    var attack_range: float = 12.0
    enemy.add_ai(AICharge.new(Globals.ai_manager, enemy, aggro_distance, lose_sight_distance, attack_range))
    enemy.add_ai(AIWander.new(Globals.ai_manager, enemy, 1, 5, 8))
    enemy.image = Globals.ENEMY_IMAGES["grunt"]
    enemy.sprite_width = 14.0
    enemy.sprite_height = 16.0
    return enemy
