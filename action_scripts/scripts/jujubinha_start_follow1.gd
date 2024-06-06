extends ActionScript

const quest_id: String = "jujubinha_location_1_quest"
const character_id: String = "jujubinha"
const node_name: String = "Jujubinha"

func run(trigger_node: Node2D, body: CharacterBody2D) -> bool:
	var character = trigger_node.get_parent().get_parent().get_node("YSort/Jujubinha") as CatFollowCharacter
	if character:
		character.animation.stop()
		if QuestManager.is_quest_active(quest_id):
			character.fsm.force_change_state("follow_player_state")
			GlobalData.data.set_character_follower(character_id, node_name)
			InteractiveObjectsData.set_value_in_object("house_3_door", "door_locked", false)
			return true
	return false
