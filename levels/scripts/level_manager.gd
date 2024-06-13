extends Node2D

@export var level_id: String = ""
@export var display_level_name: String = ""

func _ready():
	var global_data = GlobalData.get_global_var() as GlobalVariablesaaa
	if global_data:
		global_data.current_level = level_id
		global_data.display_level_name = display_level_name
	
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

