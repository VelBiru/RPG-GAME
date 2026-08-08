class_name AnimationController extends Component

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

var last_direction: Vector2 = Vector2.DOWN

func update_direction(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		return

	last_direction = direction


func play_idle() -> void:
	var direction_name := get_direction_name(last_direction)
	play("idle_" + direction_name)


func play_walk() -> void:
	var direction_name := get_direction_name(last_direction)
	play("walk_" + direction_name)


func play_run() -> void:
	var direction_name := get_direction_name(last_direction)
	play("run_" + direction_name)


func play(animation_name: String) -> void:
	if animation_player.current_animation != animation_name:
		animation_player.play(animation_name)


func get_direction_name(direction: Vector2) -> String:
	if direction == Vector2.ZERO:
		return get_direction_name(last_direction)

	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			return "right"
		else:
			return "left"

	if direction.y > 0:
		return "down"
	else:
		return "up"
