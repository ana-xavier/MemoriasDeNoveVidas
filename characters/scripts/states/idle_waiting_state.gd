extends State

@onready var body = $"../.."
@export var animation: AnimationPlayer = null
@export var animation_tree: AnimationTree = null

func enter():
	if body.animation_state:
		body.animation_state.travel("sitting_down")

