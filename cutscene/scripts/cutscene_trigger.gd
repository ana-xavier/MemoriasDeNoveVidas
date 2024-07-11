@icon("res://gui/icons/editor/cutscene_trigger.png")
extends Node2D
class_name CutsceneTrigger

@export var cutscene: Cutscene = null

var player: CharacterBody2D

func _ready():
	if InteractiveObjectsData.is_object_already_interacted(cutscene.id):
		queue_free()
	SignalBus.start_cutscene_by_id.connect(_on_signal_trigger)

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
	
func _on_signal_trigger(cutscene_id: String):
	if cutscene_id == cutscene.id:
		print("trigger")
		try_run_cutscene()
	
func get_player_node() -> MainCharacter:
	if player:
		return player
	return get_tree().get_first_node_in_group("player")
	
func get_character_node(node_name: String) -> CharacterBody2D:
	var level_node = get_parent().get_parent()
	var node_path: String = "YSort/" + node_name
	if level_node.has_node(node_path):
		return level_node.get_node(node_path)
	return null

func get_player_camera() -> Camera2D:
	if !player:
		player = get_tree().get_first_node_in_group("player")
	if player.has_node("Camera2D"):
		return player.get_node("Camera2D")
	return null

func set_character_target_path(character: CharacterBody2D, target: Vector2) -> void:
	await character.fsm.force_change_state("follow_path_state")	
	character.path_finder_component.find_and_follow_path(target)

func start_and_wait_dialog(character: CharacterBody2D, lines: Array[String]) -> void:
	var offset_y = 0
	if character is BaseHumanCharacter:
		offset_y = -12
	var pos: Vector2 = 	character.global_position
	pos.y += offset_y
	DialogManager.start_dialog(pos, lines, "", true, true)
	await DialogManager.dialog_finished
