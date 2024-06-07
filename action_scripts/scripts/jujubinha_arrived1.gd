extends ActionScript

const quest_id: String = "jujubinha_location_1_quest"
const character_id: String = "jujubinha"

func run(trigger_node: Node2D, body: CharacterBody2D) -> bool:
	var character = trigger_node.get_parent().get_parent().get_node("YSort/Jujubinha") as CatFollowCharacter
	if character:
		if (QuestManager.is_quest_active(quest_id)
			&& GlobalData.data.player_followed_by == character_id):
			
			await character.fsm.force_change_state("follow_path_state")	
			character.path_finder_component.find_and_follow_path(Vector2(-493, -228))
			await character.path_finder_component.arrived_at_target	
			
			character.fsm.force_change_state("idle_waiting_state")
			GlobalData.data.remove_character_follower()
			GlobalData.data.set_character_pos(character_id, "level_1", Vector2(-493, -228))
			
			var quest = QuestManager.get_quest_by_id(quest_id) as QuestGoToLocation
			quest.arrived_at_location = true
			return true
			
	return false
