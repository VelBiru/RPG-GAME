class_name State extends Node

signal change_state(new_state_name: String, msg: Dictionary)
var entity: Entity

func enter_state(msg: Dictionary = {}):
	set_process(true)
	set_physics_process(true)

func exit_state():
	set_process(false)
	set_physics_process(false)
	
func update(delta: float) -> void:
	pass
	
func physic_update(delta: float) -> void:
	pass
