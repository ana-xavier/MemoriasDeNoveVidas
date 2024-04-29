extends Node

var data: DialogReadyList = preload("res://resources/data/dialog_ready_list.tres")

func _ready():
	var dialog_ready_list: DialogReadyList = DataManager.load_dialogs_ready_data()
	if (dialog_ready_list != null):
		data = dialog_ready_list

func get_curr_dialog_by_character_id(character_id: int ) -> String:
	return data.get_curr_dialog_by_character_id(character_id)

func add_dialog(character_id: int, dialog_id: String) -> void:
	data.add_dialog(character_id, dialog_id)
	DataManager.save_dialogs_ready(data.dialogs_ready)
	
func remove_dialog(dialog_id: String) -> void:
	data.remove_dialog(dialog_id)
	DataManager.save_dialogs_ready(data.dialogs_ready)
