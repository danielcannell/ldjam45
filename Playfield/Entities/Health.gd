extends Node
class_name Health


var value = 100


var resistances = Config.player_resistances.duplicate()
var buffs = Config.player_buffs.duplicate()


func set_passives(rs, bs):
    resistances = rs
    buffs = bs


func damage(dmg, type):
    dmg *= self.resistances[type]
    value = max(0, value - dmg)


func alive():
    return value > 0
