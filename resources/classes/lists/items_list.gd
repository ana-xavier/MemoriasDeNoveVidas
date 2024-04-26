extends Resource
class_name ItemsList

@export var quest_items: Array[QuestItem] = []

func get_quest_item_by_id(item_id: String) -> QuestItem:
	for item in quest_items:
		if item.id == item_id:
			return item
	return null
	
