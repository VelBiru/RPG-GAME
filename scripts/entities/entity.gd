class_name Entity extends CharacterBody2D

@export var entity_data: EntityData

func init() -> void: 
	for child in $Components.get_children():
		if child is Component:
			child.init(self)
			
	$StateMachine.init(self)
	$StateMachine.start()
	
func get_component(type: Variant) -> Component:
	for child in $Components.get_children():
		if is_instance_of(child, type):
			return child
		
	return null
