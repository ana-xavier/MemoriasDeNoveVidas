extends State

@onready var body = $"../.."
@export var animation_player: AnimationPlayer
@export var animation_probability: float
@export var change_state_probability: float

var directions: Array[Vector2] = [Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]
var last_direction: Vector2

func enter():
	directions.shuffle()
	var direction: Vector2 = directions.front()
	
	if direction  == last_direction:
		direction = directions.back()
	
	body.direction = direction
	
	if randf() < animation_probability:
		if direction == Vector2.UP || direction == Vector2.DOWN:
			animation_player.play("idle_down")
		if direction == Vector2.LEFT:
			animation_player.play("idle_left")
		if direction == Vector2.RIGHT:
			animation_player.play("idle_right")

func exit():
	last_direction = body.direction
	
func transition():
	if randf() < change_state_probability:
		state_transition.emit(self, "moving_state")
