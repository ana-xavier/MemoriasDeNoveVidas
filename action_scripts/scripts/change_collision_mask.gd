extends ActionScript

func run(trigger_node: Node2D, body: CharacterBody2D) -> bool:
	body.set_collision_mask_value(3, true)
	body.set_collision_mask_value(1, false)
	return false
