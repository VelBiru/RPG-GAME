class_name MovementComponent extends Component

## Signals
signal started_moving
signal stopped_moving
signal velocity_changed(velocity: Vector2)

## Exported Parameters
@export var default_speed: float = 150.0
@export var acceleration: float = 1000.0	
@export var friction: float = 1200.0

## Internal State & References
var stats_component: StatsComponent
var last_move_direction: Vector2 = Vector2.DOWN
var is_moving: bool = false

func initialize(owner: Entity) -> void:
	super(owner)
	stats_component = entity.get_component(StatsComponent)

func get_max_speed() -> float:
	if stats_component and stats_component.movement_speed > 0:
		return stats_component.movement_speed
	return default_speed

func move(direction: Vector2, delta: float = 0.0, speed_override: float = -1.0) -> void:
	if not entity:
		return
		
	var max_speed: float = speed_override if speed_override > 0.0 else get_max_speed()
	
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		last_move_direction = direction
		var target_velocity := direction * max_speed
		
		if delta > 0.0:
			entity.velocity = entity.velocity.move_toward(target_velocity, acceleration * delta)
		else:
			entity.velocity = target_velocity
			
		if not is_moving:
			is_moving = true
			started_moving.emit()
	else:
		if delta < 0.0:
			entity.velocity = entity.velocity.move_toward(Vector2.ZERO, friction * delta)
		else:
			entity.velocity = Vector2.ZERO
		
		if is_moving and entity.velocity.length() < 1.0:
			entity.velocity = Vector2.ZERO
			is_moving = false
			stopped_moving.emit()
			
	entity.move_and_slide()
	velocity_changed.emit(entity.velocity)

func stop() -> void:
	if not entity:
		return
		
	entity.velocity = Vector2.ZERO
	entity.move_and_slide()
	
	if is_moving:
		is_moving = false
		stopped_moving.emit()
		
	velocity_changed.emit(entity.velocity)

func apply_impulse(force: Vector2) -> void:
	if not entity:
		return
	entity.velocity += force

func get_facing_direction() -> Vector2:
	return last_move_direction
