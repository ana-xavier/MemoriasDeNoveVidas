extends State

@onready var body = $"../.."
@export var animation_player: AnimationPlayer
@export var change_state_probability: float

func enter():
	var direction: Vector2 = body.direction
	
	if direction == Vector2.UP || direction == Vector2.DOWN:
		animation_player.play("sitting_down")
	if direction == Vector2.LEFT:
		animation_player.play("sitting_left")
	if direction == Vector2.RIGHT:
		animation_player.play("sitting_right")
	
func transition():
	if randf() < change_state_probability:
		state_transition.emit(self, "new_dir_state")
