extends Cutscene

@export var destination_camera: Camera2D = null

const lines = ["O que era aquilo???", "Devo estar vendo coisas."]

func prerequisites() -> bool:
	return true
	
func run() -> void:
	var character = cutscene_trigger.get_character_node("GhostCat") as GhostCat
	var player = cutscene_trigger.get_player_node()
	var player_cam = cutscene_trigger.get_player_camera()
	
	var initial_ghost_pos = character.global_position
	character.global_position = Vector2(308, -374)
	character.modulate.a = 0
	character.visible = true
	
	var tween = get_tree().create_tween()
	tween.tween_property(character, "modulate:a", 1, 2.0)
	
	CutsceneManager.start_cutscene()
	
	CameraTransition.transition_camera2D(player_cam, destination_camera)
	await tween.finished
	
	character.fsm.force_change_state("follow_path_state")	
	character.path_finder_component.find_and_follow_path(Vector2(308, -390))
	await character.path_finder_component.arrived_at_target	
	
	if character.global_position.x < player.global_position.x && player.has_node("Sprite"):
		player.get_node("Sprite").frame = 78
	else:
		player.get_node("Sprite").frame = 366
	
	character.path_finder_component.find_and_follow_path(Vector2(308, -440))
	await get_tree().create_tween().tween_property(
		destination_camera, "zoom", Vector2(1, 1), 1
		).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT).finished
	await get_tree().create_tween().tween_property(character, "modulate:a", 0, 1).finished
	
	await character.path_finder_component.arrived_at_target
	character.fsm.force_change_state("idle_waiting_state")
	character.global_position = initial_ghost_pos
	character.visible = false
	
	CameraTransition.transition_camera2D(destination_camera, player_cam, 0.5)
	await CameraTransition.transitioning_complete
	
	DialogManager.start_dialog(player.global_position, lines, "", true, true)
	await DialogManager.dialog_finished
	
	CutsceneManager.end_cutscene()

	
