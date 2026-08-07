class_name StatsComponent extends Component

signal health_change(current: int, max: int)
signal stats_changed

var current_health: int
var max_health: int 
var movement_speed: float

#var attack: int
#var defense: int
#var crit_change: float
#var crit_damage: float
var attribute: AttributeComponent

func initialize(owner: Entity) -> void:
	super(owner)
	
	attribute =  entity.get_component(AttributeComponent)
	
	if attribute:
		if not attribute.attribute_changed.is_connected(recalculate):
			attribute.attribute_changed.connect(recalculate)
		recalculate()
	
	current_health = max_health

func recalculate() -> void:
	
	var data := entity.entity_data
	
	movement_speed = data.movement_speed
	max_health = data.max_health + attribute.vitality * 10
	
	stats_changed.emit()
	
	print(attribute.vitality)
	
	
