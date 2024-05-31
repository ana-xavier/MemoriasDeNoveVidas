extends State

@onready var body = $"../.."
@export var animation_tree: AnimationTree
@export var interaction_area: InteractionArea
@export var speed: float = 50.0

var player: MainCharacter

func enter():
	player = get_tree().get_first_node_in_group("player")
	body.set_collision_layer_value(1, false)
	interaction_area.monitoring = false
	
func update(_delta: float):
	animate()
	move()
	body.move_and_slide()

func animate():
	body.animation_state.travel("Running")
	
func move():
	body.direction = player.global_position - body.global_position
	var direction = body.direction
	
	if direction != Vector2.ZERO:
		animation_tree["parameters/Running/blend_position"] = direction
		animation_tree["parameters/Sitting/blend_position"] = direction
	
	body.velocity = direction.normalized() * speed
	
	if direction.length() < 20:
		state_transition.emit(self, "idle_follow_player_state")
			
	
func exit():
	#body.set_collision_layer_value(1, true)
	interaction_area.monitoring = true
