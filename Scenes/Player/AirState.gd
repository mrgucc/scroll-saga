extends State
class_name AirState

@export var ground_state : State

func state_process(delta):
	if(character.is_on_floor()): landing()

func landing():
	playback.travel("move")
	next_state = ground_state
