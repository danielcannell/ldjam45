extends Item
class_name Focus

var action: Action
var component: Component = null
var power := 0.0

func _init(base_name: String, flavour_txt: Dictionary, action: Action, component: Component, power: float)\
                 .(base_name, flavour_txt):
    self.action = action
    self.component = component
    self.power = power

func get_screen_name():
    if component != null:
        return self.base_name + " of " + self.action.screen_text + " " + self.component.screen_name
    else:
        return self.base_name

func set_component(c):
    self.component = c
    return self
