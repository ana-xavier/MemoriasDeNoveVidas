extends State

@onready var body = $"../.."
@export var animation_player: AnimationPlayer
@export var change_state_probability: float

var wait_time: float

func randomize_wait_time():
	wait_time = randf_range(1.0, 2.0)

func enter():
	randomize_wait_time()
	var direction: Vector2 = body.direction
	
	if direction == Vector2.UP || direction == Vector2.DOWN:
		animation_player.play("sitting_down")
	if direction == Vector2.LEFT:
		animation_player.play("sitting_left")
	if direction == Vector2.RIGHT:
		animation_player.play("sitting_right")
	
func update(_delta: float):
	if wait_time > 0:
		wait_time -= _delta	
	elif randf() < change_state_probability:
		state_transition.emit(self, "new_dir_state")
	else:
		randomize_wait_time()
