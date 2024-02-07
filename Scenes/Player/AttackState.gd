extends State

@export var ground_state : State
@export var air_state: State

@export var max_attacks : int = 2
var attacks_remaining




func _on_animation_tree_animation_finished(anim_name):
	$Timer.start()
	match anim_name:
		"attack1":
			if (!$Timer.is_stopped()):
				playback.travel("attack2")
			else: state_exit_handler()
		"attack2":
			if (!$Timer.is_stopped()):
				playback.travel("attack3")
			else: state_exit_handler()
		"attack3":
			state_exit_handler()

			
func state_exit_handler():
	if character.is_on_floor(): 
		next_state = ground_state
		playback.travel("move")
	else: 
		next_state = air_state
		playback.travel("land")
