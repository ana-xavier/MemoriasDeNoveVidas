extends Quest
class_name QuestDeliverItem

@export var required_item_id: String = ""
@export var required_item_name: String = ""
@export var character_id: String = ""

func check_and_complete_quest() -> void:
	if InventoryManager.has_item(required_item_id):
		InventoryManager.remove_item(required_item_id)
		super()
