extends Node2D

func _ready():
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)
			
func _on_note_manager_closed_note():
	get_tree().paused = false

func _on_note_manager_opened_note():
	get_tree().paused = true

func _on_inventory_closed():
	get_tree().paused = false

func _on_inventory_opened():
	get_tree().paused = true

func _on_level_spawn(destination_tag: String):
	var door_path = "YSort/Doors/Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)

