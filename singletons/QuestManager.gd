extends Node

var quests = [{
	"id": "srpotatoe_item_quest",
	"character_id": 1,
	"name": "Um velho amigo",
	"description": "Ajude Sr.Batata a recuperar seu item perdido.",
	"required_item_name": "Patinho de Borracha",
	"required_item_id": "rubber_duck"
}]

var active_quests = []

var completed_quests = []

func get_quest_by_id(quest_id: String, _quests):
	for i in range(_quests.size()):
		if _quests[i]["id"] == quest_id:
			return {
				"data": _quests[i],
				"index": i
			}
		return {}

func get_quest_by_character(character_id: int):
	for quest in active_quests:
		if quest["character_id"] == character_id:
			return quest
	return null

func set_active_quest(quest_id: String):
	var quest = get_quest_by_id(quest_id, quests)
	var quest_index = quest["index"]
	if quest_index >= 0:
		active_quests.append(quest["data"])
		quests.remove_at(quest_index)
		print("Nova missão!")
# Mostrar na tela uma notificação de nova quest
# NotificationManager.show_new_quest(quest)
	
func complete_quest(quest_id: String):
	var quest = get_quest_by_id(quest_id, active_quests)
	var quest_index = quest["index"]
	if quest_index >= 0:
		completed_quests.append(quest["data"])
		active_quests.remove_at(quest_index)
		print("Completou a missão!")
# Mostrar na tela que concluiu a quest
# NotificationManager.show_completed_quest(quest)
