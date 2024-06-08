extends Cutscene

@export var destination_camera: Camera2D = null

const quest_id: String = "jujubinha_location_2_quest"
const character_id: String = "jujubinha"

func prerequisites() -> bool:
	if (QuestManager.is_quest_active(quest_id)
			&& GlobalData.data.player_followed_by == character_id):
				return true
	return false
	
func run() -> void:
	var character = cutscene_trigger.get_character_node("Jujubinha") as CatFollowCharacter
	var player_cam = cutscene_trigger.get_player_camera()
	
	CutsceneManager.start_cutscene()
	CameraTransition.transition_camera2D(player_cam, destination_camera, 3.0)
	cutscene_trigger.set_character_target_path(character, Vector2(-120, -48))
	await character.path_finder_component.arrived_at_target	
	cutscene_trigger.set_character_target_path(character, Vector2(-120, -77))
	
	await CutsceneManager.full_screen_fade_out()
	character.queue_free()
	await CutsceneManager.full_screen_fade_in()
	
	CameraTransition.transition_camera2D(destination_camera, player_cam, 1.5)
	await CameraTransition.transitioning_complete
	CutsceneManager.end_cutscene()

	GlobalData.data.remove_character_follower()
	GlobalData.data.set_character_pos(character_id, "house_3_secondfloor", Vector2(89, 11))		
	var quest = QuestManager.get_quest_by_id(quest_id) as QuestGoToLocation
	quest.arrived_at_location = true
