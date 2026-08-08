class_name StateMachine extends Node

signal state_changed(old_state: State, new_state: State)

@export var default_state: State

var current_state: State
var entity: Entity

func start() -> void:
	change_state(default_state)

func init(owner: Entity) -> void:
	entity = owner

	for state in get_children():
		if state is State:
			state.state_machine = self
			state.request_state_change.connect(change_state)

func change_state(new_state: State) -> void:
	if current_state == new_state:
		return

	var old_state := current_state

	if current_state:
		current_state.exit()

	current_state = new_state

	if current_state:
		current_state.enter()

	state_changed.emit(old_state, current_state)

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)
