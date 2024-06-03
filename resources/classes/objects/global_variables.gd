extends Resource
class_name GlobalVariables

@export var current_level: String = ""



@export var player_has_follower: bool = false
@export var player_followed_by: String = ""


func set_character_follower(character_id: String) -> void:
	player_has_follower = true
	player_followed_by = character_id
	
func remove_character_follower() -> void:
	player_has_follower = false
	player_followed_by = ""
