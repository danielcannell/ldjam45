extends Node
class_name Action

var mode: int  # enum Globals.ActionMode
var action: int  # enum Globals.Action

func _init(mode: int, action: int):
    self.mode = mode
    self.action = action

func equals(other: Action):
    return self.mode == other.mode and self.action == other.action