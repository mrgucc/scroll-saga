extends State
class_name BlockState

var blocking : bool = false
@export var blocking_area : Area2D

func on_enter():
	playback.travel("block_idle")
	blocking_area.monitoring = true
	blocking = true

func state_input(event: InputEvent):
	if (event.is_action_released("block")): handle_exit();
	if (event.is_action_pressed("attack")): transitioned.emit("AttackState")
	if (event.is_action_pressed("roll")): transitioned.emit("RollState")

func state_physics_process(_delta: float):
	if (blocking and character.is_on_floor()):
		can_move = false
	else:
		can_move = true

func handle_exit():
	blocking_area.monitoring = false
	blocking = false
	if (character.is_on_floor()):
		transitioned.emit("GroundState")
	else:
		transitioned.emit("AirState")
