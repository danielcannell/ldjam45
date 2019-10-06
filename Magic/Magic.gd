extends Node

signal passive
signal active
signal inventory_changed

var inventory = Inventory.new()
var actions = Actions.new()
var status_effects = StatusEffects.new()

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func get_active_components() -> Array:
    var active_components := []
    for focus in self.inventory.active_foci.values():
        if focus != null and focus.component != null:
            active_components.append(focus.component)
    return active_components

func _emit_inventory_changed():
    var comp_list: Array = self.inventory.inactive_components.duplicate()
    comp_list.sort_custom(Comparators, "component")
    var foci_list: Array = self.inventory.all_foci.duplicate()
    foci_list.sort_custom(Comparators, "focus")
    emit_signal("inventory_changed", comp_list, foci_list)

func _on_item_pickup(item_type: int):
    self.inventory._on_item_pickup(item_type)
    _emit_inventory_changed()

func _on_focus_equip(focus: Focus):
    if self.inventory.active_foci[focus.type] != null:
        self.inventory.active_foci[focus.type].active = false
        self.inventory.inactive_foci.append(self.inventory.active_foci[focus.type])

    focus.active = true
    self.inventory.active_foci[focus.type] = focus
    self.inventory.inactive_foci.erase(focus)

    var action = focus.action()
    match action.mode:
        Globals.ActionMode.ACTIVE:
            emit_signal("active", focus)
        Globals.ActionMode.PASSIVE:
            var resist_foci := []
            var buff_foci := []
            for f in self.inventory.active_foci:
                if f == null:
                    continue
                elif f.action().equals(actions.ELEM_PROTECT):
                    resist_foci.append(f)
                elif f.action().equals(actions.MULTIPLIER):
                    buff_foci.append(f)
            var resistances: Dictionary = self.status_effects.get_resistance(resist_foci)
            var buffs: Dictionary = self.status_effects.get_buffs(buff_foci)

            emit_signal("passive", resistances, buffs)
    _emit_inventory_changed()

func _on_enchant(focus: Focus, component: Component):
    assert self.inventory.all_foci.has(focus)
    assert self.inventory.inactive_components.has(component)

    focus.component = component
    self.inventory.inactive_components.erase(component)
    _emit_inventory_changed()

    if focus.active:
        # Re-equip the focus to update stats
        _on_focus_equip(focus)

func _on_disenchant(focus: Focus):
    assert self.inventory.all_foci.has(focus)
    assert focus.component != null

    self.inventory.inactive_components.append(focus.component)
    focus.component = null
    _emit_inventory_changed()

    if focus.active:
        # Re-equip the focus to update stats
        _on_focus_equip(focus)
