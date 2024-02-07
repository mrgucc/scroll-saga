extends State
class_name ClimbState

@export var state_machine : StateMachine

var sliding = false

func on_enter():
	
	can_move = false
	pass
	
func state_physics_process(delta: float):
	character.velocity.y = 0
	if (!sliding):
		playback.travel("wall_grab")
	
	if(character.is_on_floor()):
		playback.travel("move")
		transitioned.emit("GroundState")
		
	if (sliding):
		playback.travel("wall_slide")
		character.velocity.y = 100

func on_exit():
	sliding = false

func state_input(event: InputEvent):
	if (event.is_action_pressed("jump")):
		character.velocity.y = -200
		character.velocity.x = -500
		transitioned.emit("AirState")
	if (event.is_action_pressed("down")):
		sliding = true
	

#func _on_timer_timeout():
	#character.velocity.y = 40
	#playback.travel("wall_slide")
	
	pass # Replace with function body.
