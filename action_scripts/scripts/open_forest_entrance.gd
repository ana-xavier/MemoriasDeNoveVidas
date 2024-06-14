extends  ActionScript

func run(_trigger_node: Node2D, _body: CharacterBody2D) -> bool:
	if QuestManager.is_quest_active("pedrita_get_wood"):
		InteractiveObjectsData.set_value_in_object("forest_entrance", "door_locked", false)
		return true
	return false
