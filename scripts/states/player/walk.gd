class_name WalkState extends State

func enter() -> void:
	print("ENTER WALK")

	var animation: AnimationController = state_machine.entity.get_component(AnimationController)

	animation.play_walk()

func physics_update(_delta: float) -> void:
	
	var direction := Input.get_vector(
		"walk_left",
		"walk_right",
		"walk_up",
		"walk_down"
	)

	var movement: MovementComponent = state_machine.entity.get_component(MovementComponent)

	if direction == Vector2.ZERO:
		movement.stop()
		request_state_change.emit(state_machine.get_node("Idle"))
		return

	print("WALKING: ", direction)

	movement.walk(direction)
	movement.move()
