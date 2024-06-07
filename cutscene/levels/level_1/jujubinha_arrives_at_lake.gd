extends Cutscene

@export var destination_camera: Camera2D = null

const quest_id: String = "jujubinha_location_1_quest"
const character_id: String = "jujubinha"
const lines: Array[String] = ["Ei Misty, venha aqui!"]

func prerequisites() -> bool:
	if (QuestManager.is_quest_active(quest_id)
			&& GlobalData.data.player_followed_by == character_id):
				return true
	return false
	
func run() -> void:
	var character = cutscene_trigger.get_character_node("Jujubinha") as CatFollowCharacter
	var player_cam = cutscene_trigger.get_player_camera()
	
	await character.fsm.force_change_state("follow_path_state")	
	character.path_finder_component.find_and_follow_path(Vector2(-520, -92))
	await character.path_finder_component.arrived_at_target	
	
	CutsceneManager.start_cutscene()
	CameraTransition.transition_camera2D(player_cam, destination_camera, 2.0)
	character.path_finder_component.find_and_follow_path(Vector2(-493, -228))
	await character.path_finder_component.arrived_at_target	
	character.fsm.force_change_state("idle_waiting_state")
	await CameraTransition.transitioning_complete
	character.animation.play("idle_down")
	await character.animation.animation_finished
	character.animation.play("surprised")
	DialogManager.start_dialog(character.global_position, lines, "", true, true)
	await DialogManager.dialog_finished
	CameraTransition.transition_camera2D(destination_camera, player_cam, 0.5)
	await CameraTransition.transitioning_complete
	CutsceneManager.end_cutscene()
	
	GlobalData.data.remove_character_follower()
	GlobalData.data.set_character_pos("jujubinha", "level_1", Vector2(-493, -228))	
	var quest = QuestManager.get_quest_by_id(quest_id) as QuestGoToLocation
	quest.arrived_at_location = true


