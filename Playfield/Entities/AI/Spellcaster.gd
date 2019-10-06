extends AIBase
class_name AISpellcaster

# SPELLCASTER
#
# Keep away from the nearest player and attack from a distance.


var tracking_player: Node2D = null

var see_range: float = 0
var lose_sight_range: float = 0
var attack_range: float = 0
var keep_away_range: float = 0

func _init(manager, entity, see_range: int, lose_sight_range: int, attack_range: int, keep_away_range: int).(manager, entity):
    self.see_range = see_range
    self.lose_sight_range = lose_sight_range
    self.attack_range = attack_range
    self.keep_away_range = keep_away_range


func think():
    if not tracking_player:
        tracking_player = get_nearby_player(see_range)

    if tracking_player:
        var dist := get_pos().distance_to(tracking_player.position)
        if dist < keep_away_range:
            var diff := tracking_player.position - get_pos()
            var dir := diff.normalized()
            return GoalHelpers.go_to(get_pos() - (dir * 1000))
        elif dist < attack_range:
            return GoalHelpers.attack(tracking_player)
        elif dist > lose_sight_range:
            tracking_player = null
            return GoalHelpers.idle()
        else:
            return GoalHelpers.go_to(tracking_player.position)

    return GoalHelpers.idle()