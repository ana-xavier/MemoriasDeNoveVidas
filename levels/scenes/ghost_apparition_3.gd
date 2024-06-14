extends Cutscene

@export var destination_camera: Camera2D = null

const lines = ["Estou começando a ficar com medo..."]

func prerequisites() -> bool:
	return true
	
func run() -> void:
	var character = cutscene_trigger.get_character_node("GhostCat") as GhostCat
	var player = cutscene_trigger.get_player_node()
	var player_cam = cutscene_trigger.get_player_camera()
	
	var initial_ghost_pos = character.global_position
	character.global_position = Vector2(188, 188)
	character.modulate.a = 0
	character.visible = true
	
	CutsceneManager.start_cutscene()
	
	var tween = get_tree().create_tween()
	tween.tween_property(character, "modulate:a", 1, 1.0).set_trans(Tween.TRANS_QUART).set_delay(1)
	
	CameraTransition.transition_camera2D(player_cam, destination_camera, 1.0)
	await tween.finished
	
	character.fsm.force_change_state("follow_path_state")	
	character.path_finder_component.find_and_follow_path(Vector2(384, 100))
	await character.path_finder_component.arrived_at_target	
	character.fsm.force_change_state("idle_waiting_state")
	character.global_position = initial_ghost_pos
	character.visible = false
	
	CameraTransition.transition_camera2D(destination_camera, player_cam, 1.5)
	await CameraTransition.transitioning_complete
	
	DialogManager.start_dialog(player.global_position, lines, "", true, true)
	await DialogManager.dialog_finished
	
	await CutsceneManager.end_cutscene()

	QuestManager.set_quest_active("mysterious_apparition")
