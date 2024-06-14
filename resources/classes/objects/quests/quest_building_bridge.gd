extends QuestCharacter
class_name QuestBuildingBridge

@export var cutscene_id: String = ""
@export var item_id_1: String = ""
@export var item_amount_1: int = 0
@export var item_id_2: String = ""
@export var item_amount_2: int = 0

func check_and_complete_quest() -> void:
	InventoryManager.remove_item(item_id_1, item_amount_1)
	InventoryManager.remove_item(item_id_2, item_amount_2)
	super()
	await DialogManager.dialog_finished
	SignalBus.start_cutscene_by_id.emit(cutscene_id)

func on_going_quest_tostring() -> String:
	var result: String = ""
	result += name + ":\n"
	
	if status == Quest.Status.COMPLETE:
		result += set_checkbox_checked(objective_display) + "\n"
	else:
		result += set_checkbox(objective_display) + "\n"
		
	return result
