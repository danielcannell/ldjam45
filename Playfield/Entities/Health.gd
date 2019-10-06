extends Node
class_name Health


var value = 100


func damage(dmg):
    value = max(0, value - dmg)


func alive():
    return value > 0
