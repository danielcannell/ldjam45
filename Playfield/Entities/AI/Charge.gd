extends AIBase
class_name AICharge

# CHARGE
#
# Move toward the nearest player until within attacking distance


var tracking_player: Node2D = null

var see_range: float = 0
var lose_sight_range: float = 0
var attack_range: float = 0

func _init(manager, entity, see_range: int, lose_sight_range: int, attack_range: int).(manager, entity):
    self.see_range = see_range
    self.lose_sight_range = lose_sight_range
    self.attack_range = attack_range


func think():
    if not tracking_player:
        tracking_player = get_nearby_player(see_range)

    if tracking_player:
        var dist := get_pos().distance_to(player_pos())
        if dist < attack_range:
            return GoalHelpers.attack(tracking_player, false)
        elif dist > lose_sight_range:
            tracking_player = null
            return GoalHelpers.idle()
        else:
            return GoalHelpers.go_to(tracking_player.position)

    return GoalHelpers.idle()