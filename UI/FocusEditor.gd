extends WindowDialog


signal disenchant  # Focus
signal equip  # Focus
signal enchant  # Focus, Component


onready var focus_name := $VBoxContainer/FocusName
onready var focus_flavour_text := $VBoxContainer/FocusFlavourText
onready var focus_image := $VBoxContainer/FocusImage
onready var equip_button := $VBoxContainer/ButtonContainer/EquipButton
onready var disenchant_button := $VBoxContainer/ButtonContainer/DisenchantButton


var focus: Focus


func _ready():
    equip_button.connect("button_down", self, "on_equip")
    disenchant_button.connect("button_down", self, "on_disenchant")
    focus_image.connect("enchant", self, "on_enchant")


func show_focus(f):
    focus = f
    update_view()
    show()


func update_view():
    if focus == null:
        return

    focus_name.text = focus.name()
    focus_flavour_text.text = focus.flavour_text()
    focus_image.texture = focus.image()
    equip_button.disabled = focus.active
    disenchant_button.disabled = focus.component == null


func on_equip():
    emit_signal("equip", focus)


func on_disenchant():
    emit_signal("disenchant", focus)


func on_enchant(component):
    if focus.component == null:
        emit_signal("enchant", focus, component)
