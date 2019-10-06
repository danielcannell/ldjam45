extends KinematicBody2D
class_name Enemy


var health = 100
var ai: Array = []

const movement_speed = 32
const DEBUG_AI_GOAL = true

var current_goal = null

onready var health_bar = $HealthBar

func get_team():
    return Globals.Team.ENEMY


func damage(dmg):
    health = max(0, health - dmg)

    if health == 0:
        queue_free()

    update()


func add_ai(strategy: AIBase) -> void:
    ai.append(strategy)


func _draw():
    health_bar.set_value(health)

    if DEBUG_AI_GOAL and current_goal:
        if current_goal.type == GoalHelpers.Type.GO_TO:
            draw_line(Vector2(0,0), current_goal.position - position, Color.green, 2)
        elif current_goal.type == GoalHelpers.Type.ATTACK:
            draw_line(Vector2(0,0), current_goal.target.position - position, Color.red, 2)


func get_new_ai_goal() -> void:
    var goals: Array = []
    for i in range(ai.size()):
        var goal: GoalHelpers.AIGoal = ai[i].think()
        assert(goal != null)
        goals.append(goal)

    var ai_in_use: int = -1
    for i in range(goals.size()):
        var goal = goals[i]
        if goal.type == GoalHelpers.Type.IDLE:
            continue

        elif goal.type == GoalHelpers.Type.ATTACK:
            current_goal = goal
            break

        elif goal.type == GoalHelpers.Type.GO_TO:
            current_goal = goal
            break

        else:
            assert(false)

    if current_goal and current_goal.type == GoalHelpers.Type.IDLE:
        current_goal = null

    for i in range(ai.size()):
        if goals[i] != current_goal:
            ai[i].go_idle()

    if DEBUG_AI_GOAL:
        update()


func _physics_process(delta):
    get_new_ai_goal()

    if current_goal:
        if current_goal.type == GoalHelpers.Type.ATTACK:
            # Attack enemy
            pass

        elif current_goal.type == GoalHelpers.Type.GO_TO:
            # Move toward the target
            var diff: Vector2 = current_goal.position - position
            var dir := diff.normalized() * movement_speed
            if dir.length_squared() > diff.length_squared():
                dir = diff
            move_and_slide(dir)
