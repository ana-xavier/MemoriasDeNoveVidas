extends Quest
class_name QuestDeliverItem

@export var required_item_id: String = ""
@export var character_id: String = ""
@export var finish_objective_display: String = ""

func check_and_complete_quest() -> void:
	if InventoryManager.has_item(required_item_id):
		InventoryManager.remove_item(required_item_id)
		super()

func on_going_quest_tostring() -> String:
	var result: String = ""
	result += name + ":\n"
	
	if InventoryManager.has_item(required_item_id):
		result += set_checkbox_checked(objective_display) + "\n"
	else:
		result += set_checkbox(objective_display) + "\n"
	
	result += set_checkbox(finish_objective_display) + "\n"
		
	return result
