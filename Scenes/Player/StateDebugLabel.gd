extends Label
class_name StateDebugLabel

@export var state_machine : StateMachine
var right_face : bool = true

func _ready():
	state_machine.connect("direction_state", update_face)

func _process(delta):
	text = ("State: " + state_machine.current_state.name + "\n" +
			"Facing: " + str(right_face))

func update_face(right: bool):
	if (right): right_face = true
	else: right_face = false
