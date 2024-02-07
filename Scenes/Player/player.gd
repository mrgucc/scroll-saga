extends CharacterBody2D
class_name Player

@export var speed : float = 200.0
@export var roll_speed : float = 350.0
@onready var state_machine : StateMachine = $StateMachine
@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO

func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
	update_gravity(delta)
	move_and_slide()
	update_animation_parameters()
	update_animation_direction()
	update_animation_moving()
	
func update_gravity(delta):
	match(state_machine.current_state.name):
		"ClimbState":
			return
		_:
			if not is_on_floor():
				velocity.y += gravity * delta
			

func update_animation_parameters():
	animation_tree.set("parameters/move/blend_position", direction.x)

func update_animation_direction():
	if direction.x > 0:
		if state_machine.current_state.name != "ClimbState": sprite.flip_h = false
		$BlockArea2D.position.x = 18
	elif direction.x < 0:
		if state_machine.current_state.name != "ClimbState": sprite.flip_h = true
		$BlockArea2D.position.x = -18

func update_animation_moving():
	direction = Input.get_vector("left", "right", "up", "down")
	if (direction.x != 0 and $StateMachine.current_state.can_move):
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	pass
