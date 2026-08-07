class_name AttributeComponent extends Component

signal attribute_changed

var strength: int
var vitality: int
var agility: int
var intelligence: int
var dexterity: int 
var luck: int

func initialize(owner: Entity) -> void:
	
	super(owner)
	var data = entity.entity_data
	strength = data.strength
	vitality = data.vitality
	agility = data.agility
	intelligence = data.intelligence
	dexterity = data.dexterity
	luck = data.luck
	
	print(vitality)
