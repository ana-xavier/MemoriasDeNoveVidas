extends ActionScript

func run(trigger_node: Node2D, body: CharacterBody2D) -> bool:
	var character = trigger_node.get_parent().get_parent().get_node("YSort/Jujubinha") as CatFollowCharacter
	if character:
		if QuestManager.is_quest_active("jujubinha_location_1_quest"):
			character.fsm.force_change_state("follow_player_state")
			GlobalData.data.player_has_follower = true
			GlobalData.data.player_followed_by = "jujubinha"
			return true
	return false
