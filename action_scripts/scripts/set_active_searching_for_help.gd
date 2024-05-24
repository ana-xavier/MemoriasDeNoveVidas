extends ActionScript

const quest_id: String = "searching_for_answers"

func run(trigger_node: Node2D, body: CharacterBody2D) -> bool:
	QuestManager.set_quest_active(quest_id)
	return true
