extends Quest
class_name QuestFindingItem

@export var required_item_id: String = ""
@export var quantity: int = 0
@export var character_id: String = ""
@export var finish_objective_display: String = ""

func check_and_complete_quest() -> void:
	if InventoryManager.has_item(required_item_id, quantity):
		super()

func on_going_quest_tostring() -> String:
	var result: String = ""
	result += name + ":\n"
	var current_quantity: int = InventoryManager.get_quantity(required_item_id)
	
	if InventoryManager.has_item(required_item_id, quantity):
		result += set_checkbox_checked("3/3 " +objective_display) + "\n"
	else:
		result += set_checkbox(str(current_quantity) + "/" + str(quantity) + " " + objective_display) + "\n"
	
	result += set_checkbox(finish_objective_display) + "\n"
		
	return result
