extends AIBase
class_name AIWander

# WANDER
#
# Wander randomly around in the room, with idle time at each location.


enum State {
    IDLE,
    MOVING
}


var next_time = 0
var target_pos = Vector2(0, 0)
var current_room = null
var prev_room = null

var idle_time_min: float = 0
var idle_time_max: float = 0
var fuzzy_dist: float = 0

var state = State.IDLE


func _init(manager, entity, idle_time_min: float, idle_time_max: float, fuzzy_dist: float).(manager, entity):
    self.idle_time_min = idle_time_min
    self.idle_time_max = idle_time_max
    self.fuzzy_dist = fuzzy_dist


func go_idle():
    state = State.IDLE
    current_room = null


func think():
    if state == State.IDLE:
        if not current_room:
            var room := manager.get_room(get_pos())
            if room:
                current_room = room

        if not current_room:
            current_room = prev_room
        else:
            prev_room = current_room

        if next_time <= manager.time:
            next_time = manager.time + rand_range(idle_time_min, idle_time_max)
            state = State.MOVING
            target_pos = get_random_pos_in_room(current_room)
    elif state == State.MOVING:
        if get_pos().distance_to(target_pos) < fuzzy_dist:
            state = State.IDLE

    if state == State.IDLE:
        return GoalHelpers.idle()
    elif state == State.MOVING:
        return GoalHelpers.go_to(target_pos)

