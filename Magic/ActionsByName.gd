extends Node

var ELEM_PROTECT = Action.new(Globals.ActionMode.PASSIVE, Globals.Action.HIT)
var MULTIPLIER = Action.new(Globals.ActionMode.PASSIVE, Globals.Action.MULTIPLIER)
var HIT = Action.new(Globals.ActionMode.ACTIVE, Globals.Action.HIT)
var PROJECT = Action.new(Globals.ActionMode.ACTIVE, Globals.Action.PROJECT)
var EXPLODE = Action.new(Globals.ActionMode.ACTIVE, Globals.Action.EXPLODE)
var PROJECT_EXPLODE = Action.new(Globals.ActionMode.ACTIVE, Globals.Action.PROJECT_EXPLODE)
