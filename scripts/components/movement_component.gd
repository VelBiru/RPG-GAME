class_name MovementComponent extends Component

var direction: Vector2
var movement_speed: float
var run_speed: float

func init(owner: Entity):
	super.init(owner)
	movement_speed = entity.entity_data.movement_speed
	run_speed = movement_speed * entity.entity_data.sprint_multiplier


func walk(input_direction: Vector2) -> void:
	direction = input_direction
	entity.velocity = direction * movement_speed


func sprint(input_direction: Vector2) -> void:
	direction = input_direction
	entity.velocity = direction * run_speed


func stop() -> void:
	direction = Vector2.ZERO
	entity.velocity = Vector2.ZERO


func move() -> void:
	entity.move_and_slide()
