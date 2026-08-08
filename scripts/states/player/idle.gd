class_name IdleState extends State

func enter() -> void:
	print("Idle")

func physics_update(_delta: float) -> void:
	var direction := Input.get_vector(
		"walk_left",
		"walk_right",
		"walk_up",
		"walk_down"
	)

	var movement: MovementComponent = state_machine.entity.get_component(MovementComponent)

	movement.stop()

	if direction != Vector2.ZERO:
		request_state_change.emit(state_machine.get_node("Walk"))
