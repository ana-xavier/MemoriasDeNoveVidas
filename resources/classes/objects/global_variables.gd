extends Resource
class_name GlobalVariables

@export var current_level: String = ""
@export var display_level_name: String = ""

@export var last_time_saved: Dictionary = {}

@export var player_has_follower: bool = false
@export var player_followed_by: String = ""
@export var player_follower_node: String = ""

func set_character_follower(character_id: String, node_name: String) -> void:
	player_has_follower = true
	player_followed_by = character_id
	player_follower_node = node_name
	
func remove_character_follower() -> void:
	player_has_follower = false
	player_followed_by = ""
	player_follower_node = ""

@export var characters_pos: Dictionary = {}

func get_character_pos(character_id: String):
	if characters_pos.has(character_id):
		return characters_pos.get(character_id)
	return {}

func set_character_pos(character_id: String, level: String, pos: Vector2) -> void:
	characters_pos[character_id] = {
		"level": level,
		"position": pos
	}

func remove_character_pos(character_id: String):
	characters_pos.erase(character_id)
	
