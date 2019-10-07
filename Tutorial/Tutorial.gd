extends CanvasLayer

onready var popup = get_node("Popup")
onready var instructions = get_node("Popup/Panel/VBoxContainer/RichTextLabel")
var cur_series = []
var cur_idx = 0

# ----------------------------------------------------------------------------
# Tutorial Messages - when a tutorial event just wants to show some text.
# ----------------------------------------------------------------------------
var messages = {
    Globals.TutorialEvents.FOCUS_PICKUP: ["FOCUS_PICKUP_MESSAGE"],
    Globals.TutorialEvents.ELEMENT_PICKUP: ["ELEMENT_PICKUP_MESSAGE"],
    Globals.TutorialEvents.FOCUS_EDITOR_OPEN: ["FOCUS_EDITOR_OPEN_MESSAGE"],
    #ENEMY_SIGHTING,

    # Globals.TutorialEvents.DEMO_MESSAGE_EVENT: ["demo_message1", "demo_message2"],
}

const FOCUS_PICKUP_MESSAGE = """You have picked up a weapon!

Click it in the foci pane to equip it"""

const ELEMENT_PICKUP_MESSAGE = """You have picked up an Element!

You can use the element to enchant a Magical Focus. Who knows what will happen?!
"""

const FOCUS_EDITOR_OPEN_MESSAGE = """You have openned the Focus Editor.

Click the Equip button to equip the focus as a weapon.
Drag an Element onto the Focus to enchant it.
"""

const demo_message1 = "This is an tutorial message."
const demo_message2 = """This is another tutorial message.

It supports newlines, [u]underlines[/u], [b]bold[/b] and other bbtext stuff."""


# ----------------------------------------------------------------------------
# Tutorial Actions - when the tutorial event wants a custom handler function
# ----------------------------------------------------------------------------
var action_handlers = {
    # Globals.TutorialEvents.DEMO_ACTION_EVENT: "handle_demo_action_event",
}


func handle_demo_action_event():
    print("action occured.")


# ----------------------------------------------------------------------------
# Tutorial Code
# ----------------------------------------------------------------------------
func _ready():
    popup.get_close_button().visible = false
    # call_deferred("handle_tutorial_event", Globals.TutorialEvents.DEMO_ACTION_EVENT)


func handle_tutorial_event(ev):
    if ev in Config.tutorial_occurred:
        return

    Config.tutorial_occurred.append(ev)

    if !Config.tutorial_active:
        return

    for ms in messages:
        if ms == ev:
            cur_series = messages[ms]
            cur_idx = 0
            call_deferred("next_message")
            return

    for h in action_handlers:
        if h == ev:
            call_deferred(action_handlers[h])


func next_message():
    var message
    if len(cur_series) <= cur_idx:
        cur_series = []
        cur_idx = 0
        message = null
    else:
        message = get(cur_series[cur_idx])
        cur_idx += 1

    if !Config.tutorial_active:
        message = null
        cur_series = []
        cur_idx = 0

    show_tutorial_message(message)


func show_tutorial_message(text):
    var in_tutorial = true
    if text == null:
        in_tutorial = false
    else:
        instructions.bbcode_text = text

    get_tree().paused = in_tutorial
    get_node("Popup").visible = in_tutorial


func handle_popup_ok_pressed():
    next_message()


func on_checkbox_toggled(button_pressed):
    Config.tutorial_active = button_pressed
