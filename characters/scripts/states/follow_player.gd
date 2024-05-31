extends State

@onready var body = $"../.."
@export var animation_player: AnimationPlayer
@export var speed: float = 40.0

var player: MainCharacter

func enter():
	print("entrou")
	player = get_tree().get_first_node_in_group("player")
	
func update(_delta: float):
	var direction = player.global_position - body.global_position
	

	body.velocity = direction.normalized() * speed
	body.move_and_slide()
	
		
func exit():
	pass
