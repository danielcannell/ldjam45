extends Node
class_name Health


var value = 100


var resistances = Config.player_resistances.duplicate()
var buffs = Config.player_buffs.duplicate()


func set_passives(rs, bs):
    resistances = rs
    buffs = bs


func damage(dmg, type):
    if type < Globals.Elements._MAX:
        dmg *= self.resistances[type]

    dmg /= Config.DAMAGE_REDUCTION_FACTOR * float(buffs[Globals.Elements.ROCK])

    value = max(0, value - dmg)


func alive():
    return value > 0


func speed_boost():
    return Config.SPEED_BOOST_FACTOR * buffs[Globals.Elements.WIND]


func process(delta):
    var heal_rate = buffs[Globals.Elements.WATER] - 1
    if abs(heal_rate) > 1e-5:
        value = min(100, value + Config.HEAL_RATE * heal_rate * delta)
