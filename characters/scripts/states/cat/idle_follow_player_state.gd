extends State

@onready var body = $"../.."
@export var animation_tree: AnimationTree

var player: MainCharacter
	
func enter():
	player = get_tree().get_first_node_in_group("player")
	
	if body.direction != Vector2.ZERO:
		animation_tree["parameters/Sitting/blend_position"] = body.direction	
		body.animation_state.travel("Sitting")

func update(_delta: float):
	var direction = player.global_position - body.global_position
	
	if direction.length() >= 32:
		state_transition.emit(self, "follow_player_state")

