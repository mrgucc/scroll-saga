extends Node

class_name StateMachine

@export var character : CharacterBody2D
@export var animation_tree : AnimationTree
@export var current_state : State

var facing_right: bool
signal direction_state(facing_right : bool)

var states: Dictionary = {}

func _ready():
	for child in get_children():
		if(child is State):
			states[child.name] = child
			child.transitioned.connect(on_child_transitioned)
			
			# Set the states up with what they need to function
			child.character = character
			child.playback = animation_tree["parameters/playback"]
			
		else:
			push_warning("Child " + child.name + " is not a State for CharacterStateMachine")

func _process(delta):
	current_state.state_process(delta)
	
func _physics_process(delta):
	current_state.state_physics_process(delta)
	emit_signal("direction_state", !character.sprite.flip_h)
	
func on_child_transitioned(new_state_name: StringName) -> void:
	var new_state = states.get(new_state_name)
	if new_state != null:
		if new_state != current_state:
			current_state.on_exit()
			new_state.on_enter()
			current_state = new_state
	else:
		push_warning("Called transition on a state that does not exist")
		
func _input(event : InputEvent):
	current_state.state_input(event)


