extends Cutscene

const lines = ["Pronto! A ponte foi consertada.", "Agora todos podemos ir para a cidade!"]

@export var destination_camera: Camera2D = null

func prerequisites() -> bool:
	return true
	
func run() -> void:
	var player_cam = cutscene_trigger.get_player_camera()
	var character = cutscene_trigger.get_character_node("George")
	var char_start_pos: Vector2 = character.global_position
	var char_dialog_pos: Vector2 = character.global_position
	char_dialog_pos.y += character.dialog_component.text_box_y_offset
	
	CutsceneManager.start_cutscene()
	CameraTransition.transition_camera2D(player_cam, destination_camera, 1.5)
	cutscene_trigger.set_character_target_path(character, Vector2(396, 133))
	
	CutsceneManager.full_screen_fade_out(4)
	await character.path_finder_component.arrived_at_target	
	
	# lógica para mudar a ponte
	SignalBus.rebuilt_bridge.emit()
	InteractiveObjectsData.set_value_in_object("level_1_bridge", "bridge_rebuilt", true)
	
	cutscene_trigger.set_character_target_path(character, char_start_pos)
	await CutsceneManager.full_screen_fade_in(2)
	
	CameraTransition.transition_camera2D(destination_camera, player_cam, 1.5)
	await character.path_finder_component.arrived_at_target	
	character.fsm.force_change_state("idle_state")
	DialogManager.start_dialog(char_dialog_pos, lines, "", true, true)
	await DialogManager.dialog_finished
	CutsceneManager.end_cutscene()
