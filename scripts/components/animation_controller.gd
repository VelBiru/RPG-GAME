class_name AnimationController extends Component

signal animation_started(anim_name: String)
signal animation_finished(anim_name: String)

@export var animation_player: AnimationPlayer
@export var appearance_node: Node2D
@export var default_state: String = "idle"

var current_state: String = ""
var last_direction: Vector2 = Vector2.DOWN
var is_locked: bool = false

func initialize(owner: Entity) -> void:
	super(owner)
	
	if not animation_player:
		animation_player = owner.get_node_or_null("Appearance/AnimationPlayer")
	
	if not appearance_node:
		appearance_node = owner.get_node_or_null("Appearance")
		
	if animation_player and not animation_player.animation_finished.is_connected(_on_animation_finished):
		animation_player.animation_finished.connect(_on_animation_finished)

func play_state(state: String, direction: Vector2 = Vector2.ZERO, force: bool = false) -> void:
	if is_locked and not force:
		return
		
	# 1. Idle requirement: Always use "idle_down"
	if state == "idle":
		play_animation("idle_down", force)
		return

	# 2. Movement direction & sprite flipping
	var move_dir := direction if direction != Vector2.ZERO else last_direction
	if direction != Vector2.ZERO:
		last_direction = direction
		
	var target_anim := state

	# Horizontal movement: Use walk_left and flip scale.x when moving Right
	if abs(move_dir.x) > abs(move_dir.y):
		target_anim = state + "_left"
		
		if appearance_node:
			if move_dir.x > 0: # Moving Right -> Flip
				appearance_node.scale.x = -abs(appearance_node.scale.x)
			else:              # Moving Left -> Normal
				appearance_node.scale.x = abs(appearance_node.scale.x)
	else:
		# Vertical movement: Reset flip scale back to positive
		if appearance_node:
			appearance_node.scale.x = abs(appearance_node.scale.x)
			
		if move_dir.y > 0:
			target_anim = state + "_down"
		else:
			target_anim = state + "_up"

	play_animation(target_anim, force)

## Plays animation by exact name
func play_animation(anim_name: StringName, force: bool = false) -> void:
	if not animation_player:
		return
	if is_locked and not force:
		return
	if current_state == anim_name and animation_player.is_playing() and not force:
		return
		
	if animation_player.has_animation(anim_name):
		current_state = anim_name
		animation_player.play(anim_name)
		animation_started.emit(anim_name)

func lock_animation() -> void:
	is_locked = true

func unlock_animation() -> void:
	is_locked = false

func _on_animation_finished(animation: StringName) -> void:
	animation_finished.emit(animation)
