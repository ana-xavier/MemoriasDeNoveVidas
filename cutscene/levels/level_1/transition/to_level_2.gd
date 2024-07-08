extends Cutscene

func prerequisites() -> bool:
	return true
	
func run() -> void:
	var character = cutscene_trigger.get_character_node("Misty") as CatFollowCharacter
	var player = cutscene_trigger.get_player_node()
	character.position = player.global_position
	player.visible = false
	
	CutsceneManager.start_cutscene()
	
	await character.fsm.force_change_state("follow_path_state")	
	character.path_finder_component.find_and_follow_path(Vector2(295, 120))
	await character.path_finder_component.arrived_at_target	
	character.path_finder_component.find_and_follow_path(Vector2(335, 120))
	
	await CutsceneManager.full_screen_fade_out(1.0, 1.0)
	CutsceneManager.end_cutscene()
	CutsceneManager.full_screen_fade_in(1.0, 2.0)
	player.visible = true
	player.global_position = Vector2(534, 47)
