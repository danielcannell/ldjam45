class_name GoalHelpers


enum Type {
    IDLE,
    GO_TO,
    ATTACK_CLOSE,
    ATTACK_SHOOT,
}


class AIGoal:
    var type = Type.IDLE
    var position: Vector2 = Vector2(0, 0)
    var target: Node2D = null

    func to_string() -> String:
        if type == Type.IDLE:
            return "IDLE"
        elif type == Type.GO_TO:
            return "GO TO " + str(position)
        elif type == Type.ATTACK:
            return "ATTACK " + str(target)
        else:
            assert(false)
            return ""


static func attack(player: Node2D, ranged: bool) -> AIGoal:
    var goal := AIGoal.new()
    if ranged:
        goal.type = Type.ATTACK_SHOOT
    else:
        goal.type = Type.ATTACK_CLOSE
    goal.target = player
    return goal


static func go_to(pos: Vector2) -> AIGoal:
    var goal := AIGoal.new()
    goal.type = Type.GO_TO
    goal.position = pos
    return goal


static func idle() -> AIGoal:
    var goal := AIGoal.new()
    goal.type = Type.IDLE
    return goal
