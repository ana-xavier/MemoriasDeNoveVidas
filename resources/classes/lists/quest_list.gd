extends Resource
class_name QuestList

@export var quests: Array[Quest] = []

func get_quest_by_id(quest_id: String) -> Quest:
	for quest in quests:
		if (quest.id == quest_id && quest.status == Quest.Status.ACTIVE):
			return quest
	return null

func get_quest_by_character_id(character_id: String) -> Quest:
	for quest in quests:
		if quest is QuestDeliverItem or quest is QuestGoToLocation or quest is QuestFindingItem:
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

func is_quest_inactive(quest_id: String) -> bool:
	for quest in quests:
		if (quest.id == quest_id):
			return quest.status == Quest.Status.INACTIVE
	return false

func is_quest_active(quest_id: String) -> bool:
	for quest in quests:
		if (quest.id == quest_id):
			return quest.status == Quest.Status.ACTIVE
	return false

func is_quest_complete(quest_id: String) -> bool:
	for quest in quests:
		if (quest.id == quest_id):
			return quest.status == Quest.Status.COMPLETE
	return false
