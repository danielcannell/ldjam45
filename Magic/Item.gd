extends Node

class_name Item

var screen_name := ""
var flavour_text := {default: ""}

func _init(screen_name, flavour_text):
	self.screen_name = screen_name
	self.flavour_text = flavour_text

# Get the flavour text, which may be special-cased
func get_flavour_text(item_name):
	return self.flavour_text.get(item_name, self.flavour_text.default)
