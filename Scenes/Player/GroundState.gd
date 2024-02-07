extends State
class_name GroundState

@export var jump_velocity : float = -350.0


func on_enter():
	playback.travel('move')
	
func state_process(_delta):
	pass
	
func state_input(event: InputEvent):
	if (event.is_action_pressed("jump")): transitioned.emit("AirState")
	if (event.is_action_pressed("attack")): transitioned.emit("AttackState")
	if (event.is_action_pressed("block")): transitioned.emit("BlockState")
	if (event.is_action_pressed("roll")): transitioned.emit("RollState")

