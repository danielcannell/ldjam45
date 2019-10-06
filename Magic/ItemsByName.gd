extends Node
class_name ItemsByName

var ActionsByName = preload("ActionsByName.gd").new()
var Component = preload("Component.gd")

var base_foci := {
    Globals.Foci.STICK: Focus.new(
        "Stick", {"default": "A stick"}, ActionsByName.ELEM_PROTECT, null, 1.0),
    Globals.Foci.WAND: Focus.new(
        "Wand", {"default": "This wand shoots things"}, ActionsByName.HIT, null, 1.0),
    Globals.Foci.STAFF: Focus.new(
        "Staff", {"default": "Shoots EXPLOSIONS!!!"}, ActionsByName.EXPLODE, null, 1.0),
    Globals.Foci.HAT: Focus.new(
        "Hat", {"default": "A Wizard's hat"}, ActionsByName.MULTIPLIER, null, 1.0),
    Globals.Foci.RING: Focus.new(
        "Ring", {"default": "A golden ring"}, ActionsByName.ELEM_PROTECT, null, 1.0)
}

var element_components := {
    Globals.Elements.FIRE: Component.new(Globals.ComponentType.ELEMENT, Globals.Elements.FIRE),
    Globals.Elements.WATER: Component.new(Globals.ComponentType.ELEMENT, Globals.Elements.WATER),
    Globals.Elements.WIND: Component.new(Globals.ComponentType.ELEMENT, Globals.Elements.WIND),
    Globals.Elements.ROCK: Component.new(Globals.ComponentType.ELEMENT, Globals.Elements.ROCK)
}

var constitution_components := {
    Globals.Constitution.HEALTH: Component.new(Globals.ComponentType.CONSTITUTION, Globals.Constitution.HEALTH),
    Globals.Constitution.SPEED: Component.new(Globals.ComponentType.CONSTITUTION, Globals.Constitution.SPEED)
}

var world_items := {
    Globals.WorldItem.HAT: self.base_foci[Globals.Foci.HAT],
    Globals.WorldItem.TORCH: self.base_foci[Globals.Foci.STICK].set_component(self.element_components[Globals.Elements.FIRE])
}
