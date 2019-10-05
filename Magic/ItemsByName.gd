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
    Globals.Elements.FIRE: Component.new("Fire", {"default": "It's HOT"}, Globals.ComponentType.ELEMENT),
    Globals.Elements.WATER: Component.new("Water", {"default": "Wet"}, Globals.ComponentType.ELEMENT),
    Globals.Elements.WIND: Component.new("Wind", {"default": "Windy"}, Globals.ComponentType.ELEMENT),
    Globals.Elements.ROCK: Component.new("Rock", {"default": "Hard"}, Globals.ComponentType.ELEMENT)
}

var constitution_components := {
    Globals.Constitution.HEALTH: Component.new("Damage Resistance", {"default": "Feeling tough?!?"}, Globals.ComponentType.CONSTITUTION),
    Globals.Constitution.SPEED: Component.new("Speed", {"default": "Faster!!!"}, Globals.ComponentType.CONSTITUTION)
}

var world_items := {
    Globals.WorldItem.HAT: self.base_foci[Globals.Foci.HAT],
    Globals.WorldItem.TORCH: self.base_foci[Globals.Foci.STICK].set_component(self.element_components[Globals.Elements.FIRE])
}
