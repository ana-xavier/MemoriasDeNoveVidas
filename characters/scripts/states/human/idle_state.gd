extends State

@export var body: BaseHumanCharacter = null
@export var animation_player: AnimationPlayer = null

func enter():
	animation_player.play("idle_down")
	
func exit():
	animation_player.stop()
