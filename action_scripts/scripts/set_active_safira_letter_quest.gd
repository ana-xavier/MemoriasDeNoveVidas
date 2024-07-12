extends ActionScript

const prerequisite_active_quest: String = "deliver_letters"
const quest_id: String = "safira_letter_quest"

func run(_trigger_node: Node2D, _body: CharacterBody2D) -> bool:
	if QuestManager.is_quest_active(prerequisite_active_quest):
		QuestManager.set_quest_active(quest_id)
		return true
	return false
