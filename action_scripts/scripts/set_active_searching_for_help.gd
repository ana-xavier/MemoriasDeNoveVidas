extends ActionScript

const quest_id: String = "searching_for_answers"

func run(_trigger_node: Node2D, _body: CharacterBody2D) -> bool:
	QuestManager.set_quest_active(quest_id)
	return true
