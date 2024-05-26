extends State

@onready var body = $"../.."
@export var animation_player: AnimationPlayer
@export var change_state_probability: float

var direction: Vector2

func enter():
	direction = body.direction

func update(_delta: float):
	_animate()
	var new_position = body.position + direction * body.speed * _delta
	var distance_from_start = new_position.distance_to(body.start_position)

	if distance_from_start <= body.max_distance_from_start:
		body.position = new_position
	else:
		state_transition.emit(self, "idle_state")

func _animate():
	if direction.x == -1:
		animation_player.play("walking_left")
	if direction.x == 1:
		animation_player.play("walking_right")
	if direction.y == -1:
		animation_player.play("walking_up")
	if direction.y == 1:
		animation_player.play("walking_down")
		
func transition():
	if randf() < change_state_probability:
		state_transition.emit(self, "idle_state")
