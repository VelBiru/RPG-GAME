class_name PlayerWalkState extends State

var movement: MovementComponent
var animation: AnimationController

func enter_state(msg: Dictionary = {}) -> void:
	movement = entity.get_component(MovementComponent)
	animation = entity.get_component(AnimationController)

func physic_update(delta: float) -> void:
	var input_dir := Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	
	if input_dir == Vector2.ZERO:
		change_state.emit("Idle")
		return

	if movement:
		movement.move(input_dir, delta)

	if animation and movement:
		animation.play_state("walk", movement.get_facing_direction())
