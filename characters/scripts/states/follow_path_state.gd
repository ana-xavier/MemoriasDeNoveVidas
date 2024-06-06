extends State

@onready var body = $"../.."
@export var animation_tree: AnimationTree
@export var path_finder_component: PathFinderComponent

func update(_delta: float):
	if path_finder_component.is_following_path:
		var direction = path_finder_component.direction
		
		if direction != Vector2.ZERO:
			animation_tree["parameters/Running/blend_position"] = direction
		
		body.animation_state.travel("Running")
