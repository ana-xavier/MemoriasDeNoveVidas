extends ActionScript

func run(_trigger_node: Node2D, _body: CharacterBody2D) -> bool:
	if QuestManager.is_quest_complete("srpotatoe_item_quest"):
		InteractiveObjectsData.set_value_in_object("house_3_window", "door_locked", false)
		return true
	return false
