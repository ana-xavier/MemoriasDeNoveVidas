@icon("res://gui/icons/editor/cutscene_trigger.png")
extends Node2D
class_name CutsceneTrigger

@export var cutscene: Cutscene = null

var player: CharacterBody2D 

func _ready():
	if InteractiveObjectsData.is_object_already_interacted(cutscene.id):
		queue_free()

func try_run_cutscene() -> void:
	if cutscene.prerequisites():
		await cutscene.run()
		if cutscene.one_time_only:
			InteractiveObjectsData.set_object_already_interacted(cutscene.id)
			queue_free()

func _on_trigger_area_entered(body):
	if body is MainCharacter:
		player = body
		try_run_cutscene()
		
func get_player_node() -> MainCharacter:
	return player if player else null
	
func get_character_node(node_name: String) -> CharacterBody2D:
	var level_node = get_parent().get_parent()
	var node_path: String = "YSort/" + node_name
	if level_node.has_node(node_path):
		return level_node.get_node(node_path)
	return null

func get_player_camera() -> Camera2D:
	if player && player.has_node("Camera2D"):
		return player.get_node("Camera2D")
	return null

