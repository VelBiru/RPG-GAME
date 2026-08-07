class_name PlayerIdleState extends State

var movement: MovementComponent
var animation: AnimationController

func enter_state(msg: Dictionary = {}) -> void:
	movement = entity.get_component(MovementComponent)
	animation = entity.get_component(AnimationController)
		
	if movement:
		movement.stop()
		
	if animation:
		var facing_dir = movement.get_facing_direction() if movement else Vector2.DOWN
		animation.play_state("idle", facing_dir)

func update(delta: float) -> void:
	var input_dir := Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	if input_dir != Vector2.ZERO:
		change_state.emit("Walk")
