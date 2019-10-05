extends Node

var Action = preload("Action.gd")

var ELEM_PROTECT = Action.new(Globals.ActionMode.PASSIVE, "RESIST", "Elemental Protection from")
var MULTIPLIER = Action.new(Globals.ActionMode.PASSIVE, "INCREASE", "Increase")
var HIT = Action.new(Globals.ActionMode.ACTIVE, "HIT", "Hit with")
var PROJECT = Action.new(Globals.ActionMode.ACTIVE, "PROJECT", "Project")
var EXPLODE = Action.new(Globals.ActionMode.ACTIVE, "EXPLODE", "Explode")
var PROJECT_EXPLODE = Action.new(Globals.ActionMode.ACTIVE, "PROJECT_EXPLODE", "Shoot Explosions of")
