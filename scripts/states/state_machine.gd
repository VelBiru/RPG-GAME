class_name StateMachine extends State

@export var initial_state: State

var current_state: State = null
var states: Dictionary = {}

func initialize(owner: Entity) -> void:
	entity = owner
	
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.entity = owner
			child.change_state.connect(_on_state_change_requested)
			if child is StateMachine:
				child.initialize(owner)

	if initial_state:
		transition_to(initial_state.name)
	elif get_child_count() > 0 and get_child(0) is State:
		transition_to(get_child(0).name)

## Godot frame callbacks that drive the state machine
func _process(delta: float) -> void:
	update(delta)

func _physics_process(delta: float) -> void:
	physic_update(delta)

## State lifecycle forwarding
func enter_state(msg: Dictionary = {}) -> void:
	if current_state:
		current_state.enter_state(msg)

func exit_state() -> void:
	if current_state:
		current_state.exit_state()

func update(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func physic_update(delta: float) -> void:
	if current_state:
		current_state.physic_update(delta)

## Transition logic
func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	var key := target_state_name.to_lower()
	if not states.has(key):
		push_warning("StateMachine: State '%s' does not exist in %s." % [target_state_name, name])
		return
	
	if current_state:
		current_state.exit_state()
	
	current_state = states[key]
	current_state.enter_state(msg)

func _on_state_change_requested(new_state_name: String, msg: Dictionary = {}) -> void:
	transition_to(new_state_name, msg)
