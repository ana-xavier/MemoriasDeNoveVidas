extends Resource
class_name PlayerInventory

@export var quest_items: Array[QuestItem] = []

func add_item(item: QuestItem) -> void:
	quest_items.append(item)

func remove_item(id: String) -> void:
	for i in range(quest_items.size()):
		if quest_items[i]["id"] == id:
			quest_items.remove_at(i)
			return

func has_item(id: String) -> bool:
	for item in quest_items:
		if item["id"] == id:
			return true
	return false
