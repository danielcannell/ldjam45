extends Item
class_name Focus

enum Mode {NONE, ACTIVE, PASSIVE}
enum Target {NONE, SELF, PROJECTILE, AREA_PROJECTILE, AREA_SELF}

var mode: int = Mode.NONE
var target: int = Target.NONE
var component: Component = null
var power_level: int = 0

func _init(screen_name, flavour_txt, mode, target, component, power_level).(screen_name, flavour_txt):
	self.mode = mode
	self.target = target
	set_component(component)
	self.power_level = power_level

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_component(c: Component):
	self.component = c
	if component != null:
		self.screen_name = self.screen_name + " of " + c.screen_name



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

