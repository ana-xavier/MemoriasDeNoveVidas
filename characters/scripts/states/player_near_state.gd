extends State

@onready var body = $"../.."
@export var animation_player: AnimationPlayer

var player_was_left: bool = false
var player_was_right: bool = false


func update(_delta: float):
	var body_pos_x = body.global_position.x
	var player_pos_x = body.player_body.global_position.x
	
	if body_pos_x >= player_pos_x && !player_was_left:
		animation_player.play("sitting_left")
		player_was_left = true
		player_was_right = false
	elif body_pos_x < player_pos_x && !player_was_right:
		animation_player.play("sitting_right")
		player_was_left = false
		player_was_right = true

func exit():
	player_was_left = false
	player_was_right = false
