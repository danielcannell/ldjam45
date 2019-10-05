extends Focus
class_name PassiveSelfFocus

# Action constant (because enums are insufficient)
class ActionType:
	var type
	var screen_text
	func _init(type, screen_text):
		self.type = type
		self.screen_text = screen_text

var Action = {
	PROTECT: ActionType.new("PROTECT", "Protection from"),
	INCREASE: ActionType.new("INCREASE", "Increase"),
	REGEN: ActionType.new("REGEN", "Regenerate")
}

var action: ActionType
func _init(screen_name, flavour_txt, mode, target, component, power_level, action: ActionType)\
		.(screen_name, flavour_text, Mode.Passive, Target.SELF, component, power_level):
	self.action = action
