extends State
class_name RollState

var char_direction = 1
@export var roll_speed : int = 400
@export var state_machine : StateMachine
@export var standard_collision : CollisionShape2D
@export var rolling_collision: CollisionShape2D

var connected = false

func on_enter():
	standard_collision.disabled = true
	rolling_collision.disabled = false
	if !connected: 
		state_machine.connect("direction_state", update_direction)
		connected = true
	playback.travel("roll")
	
func state_physics_process(_delta):
	character.velocity.x = roll_speed * char_direction
	pass

func update_direction(facing_right: bool):
	if (facing_right):
		char_direction = 1
	else:
		char_direction = -1
		
func on_exit():
	standard_collision.disabled = false
	rolling_collision.disabled = true

func _on_animation_tree_animation_finished(anim_name):
	if (anim_name == "roll"):
		if (Input.is_action_pressed("block")):
			transitioned.emit("BlockState")
		elif (character.is_on_floor()):
			transitioned.emit("GroundState")
		elif(character.is_on_wall_only()):
			pass
		else:
			transitioned.emit("AirState")
	pass # Replace with function body.
