extends CharacterBody2D

const SPEED = 50


@export var aggro_range = 99

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/StateMachine/playback") as AnimationNodeStateMachinePlayback

func _physics_process(_delta: float) -> void:
	var state = playback.get_current_node()
	
	match state:
		
		"Idle": pass
		"Chase": 
			var player = get_player()
			if player is Player:
				velocity = global_position.direction_to(player.global_position) * SPEED
			else:
				velocity  = Vector2.ZERO
			move_and_slide()	
		
		
func get_player() -> Player:
	return get_tree().get_first_node_in_group("player")

func is_player_in_range() -> bool:
	var player: = get_player()
	if player is Player:
		var distance_to_player = global_position.distance_to(player.global_position)
		if distance_to_player < aggro_range:
			return true
	return false
	
