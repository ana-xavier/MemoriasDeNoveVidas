extends Resource
class_name QuestList

@export var quests: Array[Quest] = []

func get_quest_by_id(quest_id: String) -> Quest:
	for quest in quests:
		if (quest.id == quest_id):
			return quest
	return null

func get_quest_by_character_id(character_id: String) -> Quest:
	for quest in quests as Array[QuestDeliverItem]:
		if (quest.character_id == character_id && quest.status == Quest.Status.ACTIVE):
			return quest
	return null

func set_quest_active(quest_id: String) -> void:
	for quest in quests:
		if (quest.id == quest_id):
			quest.status = Quest.Status.ACTIVE
	
func set_quest_complete(quest_id: String) -> void:
	for quest in quests:
		if (quest.id == quest_id):
			quest.status = Quest.Status.COMPLETE
			return

func is_quest_complete(quest_id: String) -> bool:
	print("quest completa?")
	for quest in quests:
		print(quest.id + "==" + quest_id + " ?")
		if (quest.id == quest_id):
			print(" -- return:")
			print(quest.status == Quest.Status.COMPLETE)
			return quest.status == Quest.Status.COMPLETE
	return false
