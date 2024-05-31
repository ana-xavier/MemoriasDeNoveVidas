extends InteractionArea
class_name InteractionJumpArea

@onready var player_body = get_tree().get_first_node_in_group("player") as MainCharacter

var collision_mask_layer: int = 1

func _on_area_entered(area):
	if not player_body.get_collision_mask_value(collision_mask_layer):
		InteractionManager.register_area(self)

func _on_area_exited(area):
	InteractionManager.unregister_area(self)
