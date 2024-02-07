extends State
class_name AirState

@export var jump_velocity : float = -350.0

func on_enter():
	
	if character.is_on_floor(): 
		character.velocity.y = jump_velocity
		playback.travel("jump")
	else:
		playback.travel("land")
	
func state_input(event: InputEvent):
	if (event.is_action_pressed("attack")): transitioned.emit("AttackState")
	if (event.is_action_pressed("block")): transitioned.emit("BlockState")

func state_physics_process(delta):
	if (character.is_on_floor()):
		transitioned.emit("GroundState")
