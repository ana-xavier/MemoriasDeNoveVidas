extends State

@export var animation: AnimationPlayer = null

func enter():
	animation.play("sitting_down")
	
func exit():
	animation.stop()
