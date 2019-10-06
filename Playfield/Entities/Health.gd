extends Node
class_name Health


signal on_heal


var value = 100
var heal_cooldown: float = 1.0


var resistances = Config.player_resistances.duplicate()
var buffs = Config.player_buffs.duplicate()


func set_passives(rs, bs):
    resistances = rs
    buffs = bs


func damage(dmg, type) -> float:
    if type < Globals.Elements._MAX:
        dmg *= self.resistances[type]

    dmg /= Config.DAMAGE_REDUCTION_FACTOR * float(buffs[Globals.Elements.ROCK])

    value = max(0, value - dmg)
    return dmg


func alive():
    return value > 0


func speed_boost():
    return Config.SPEED_BOOST_FACTOR * buffs[Globals.Elements.WIND]


func process(delta):
    heal_cooldown -= delta
    if heal_cooldown < 0:
        heal_cooldown = Config.HEAL_INTERVAL

        var heal_rate = Config.HEAL_RATE * (buffs[Globals.Elements.WATER] - 1)
        heal_rate -= Config.BURN_RATE * (buffs[Globals.Elements.FIRE] - 1)
        if abs(heal_rate) > 1e-5:
            if value < 100:
                emit_signal("on_heal", heal_rate)
            value = min(100, value + heal_rate)
