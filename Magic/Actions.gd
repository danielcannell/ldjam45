extends Node
class_name Actions

class FocusAction:
    var mode: int  # enum Globals.ActionMode
    var action: int  # enum Globals.Action

    func _init(mode: int, action: int):
        self.mode = mode
        self.action = action

    func equals(other: FocusAction) -> bool:
        return self.mode == other.mode and self.action == other.action

var ELEM_PROTECT = FocusAction.new(Globals.ActionMode.PASSIVE, Globals.Action.HIT)
var MULTIPLIER = FocusAction.new(Globals.ActionMode.PASSIVE, Globals.Action.MULTIPLIER)
var HIT = FocusAction.new(Globals.ActionMode.ACTIVE, Globals.Action.HIT)
var PROJECT = FocusAction.new(Globals.ActionMode.ACTIVE, Globals.Action.PROJECT)
var EXPLODE = FocusAction.new(Globals.ActionMode.ACTIVE, Globals.Action.EXPLODE)
var PROJECT_EXPLODE = FocusAction.new(Globals.ActionMode.ACTIVE, Globals.Action.PROJECT_EXPLODE)

var by_focus = {
    Globals.Foci.STICK: self.HIT,
    Globals.Foci.WAND: self.PROJECT,
    Globals.Foci.STAFF: self.EXPLODE,
    Globals.Foci.HAT: self.MULTIPLIER,
    Globals.Foci.RING: self.ELEM_PROTECT
}