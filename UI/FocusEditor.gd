extends WindowDialog


onready var focus_name := $VBoxContainer/FocusName
onready var focus_flavour_text := $VBoxContainer/FocusFlavourText
onready var focus_image := $VBoxContainer/ImageContainer/FocusImage
onready var component_image := $VBoxContainer/ImageContainer/ComponentImage


func show_focus(focus):
    focus_name.text = focus.name()
    focus_flavour_text.text = focus.flavour_text()
    show()
