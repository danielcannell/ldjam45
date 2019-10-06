extends AIBase
class_name AIGoHome

# GO HOME
#
# Return to where it started


var current_room = null
var home_position = null


func _init(manager, entity).(manager, entity):
    pass


func think():
    if home_position == null:
        home_position = get_pos()

    if get_pos().distance_squared_to(home_position) < 1:
        return GoalHelpers.idle()
    else:
        return GoalHelpers.go_to(home_position)
