class_name State extends Node

signal request_state_change(new_state: State)

var state_machine: StateMachine
var entity: Entity

func init(machine: StateMachine):
	state_machine = machine
	entity = machine.entity

func enter() -> void:
	pass


func exit() -> void:
	pass


func update(delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	pass
