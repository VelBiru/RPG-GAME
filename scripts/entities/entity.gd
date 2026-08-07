class_name Entity extends CharacterBody2D

@export var entity_data: EntityData

var _components: Dictionary = {}

func _ready() -> void:
	initialize()

func initialize() -> void:
	_components.clear()
	
	# Register components first
	for child in $Components.get_children():
		if child is Component:
			_components[child.get_script()] = child

	# Initialize components second
	for child in $Components.get_children():
		if child is Component:
			child.initialize(self)
			
	$StateMachine.initialize(self)

func get_component(type: Variant) -> Component:
	return _components.get(type, null) as Component
