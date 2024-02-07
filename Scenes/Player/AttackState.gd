extends State
class_name AttackState

@export var ground_state : State
@export var air_state: State

var attack_que : String
var attack_input_cd : bool = false
var attack_count : int = 0


func on_enter():
	handle_attack(1)
	
func state_physics_process(delta):
	if (character.is_on_floor() && attack_input_cd):
		can_move = false
	else:
		can_move = true

func state_input(event: InputEvent):
	if (event.is_action_pressed("attack") and !attack_input_cd and attack_count < 3):
		match (attack_count):
			1:
				handle_attack(2)
			2: 
				handle_attack(3)

func _on_animation_tree_animation_finished(anim_name):
	if (["attack1", "attack2", "attack3"].has(anim_name)):
		handle_exit()

func _on_timer_timeout():
	attack_input_cd = false

func handle_attack(atk_num : int):
	$Timer.start()
	attack_input_cd = true
	playback.travel("attack" + str(atk_num))
	attack_count = atk_num


	#add dmg logic later

func handle_exit():
	can_move = true
	if (character.is_on_floor()):
		transitioned.emit("GroundState")
	else:
		transitioned.emit("AirState")




