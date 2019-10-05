extends Node
class_name Action

var mode: int  # enum Mode
var type: String
var screen_text: String
func _init(mode: int, type: String, screen_text: String):
    self.mode = mode
    self.type = type
    self.screen_text = screen_text