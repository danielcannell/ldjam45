extends Item
class_name Focus

enum Mode {ACTIVE, PASSIVE}

# Action constant (because enums are insufficient)
class ActionType:
	var type
	var mode
	var screen_text
	func _init(mode, type, screen_text):
		self.mode = mode
		self.type = type
		self.screen_text = screen_text

var Action = {
	RESIST: ActionType.new(Mode.PASSIVE, "RESIST", "Protection from"),
	INCREASE: ActionType.new(Mode.PASSIVE, "INCREASE", "Increase"),
	REGEN: ActionType.new(Mode.PASSIVE, "REGEN", "Regenerate"),
	PROJECT: ActionType.new(Mode.ACTIVE, "PROJECT", "Project"),
	EXPLODE: ActionType.new(Mode.ACTIVE, "EXPLODE", "Explode"),
	PROJECT_EXPLODE: ActionType.new(Mode.ACTIVE, "PROJECT_EXPLODE", "Shoot Explosions of")
}

var action: ActionType
var component: Component = null
var power := 0.0

func _init(screen_name, flavour_txt, action, component, power).(screen_name, flavour_txt):
	self.action = action
	self.component = component
	self.power = power

func get_screen_name():
	if component != null:
		return self.base_name + " of " + self.action.screen_text + " " + self.component.screen_name
	else:
		return self.base_name
