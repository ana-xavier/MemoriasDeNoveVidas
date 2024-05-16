extends Node

var data: DialogReadyList = null

func _ready():
	pass

func get_curr_dialog_by_character_id(character_id: String ) -> String:
	return data.get_curr_dialog_by_character_id(character_id)

func is_dialog_already_done(dialog_id: String) -> bool:
	return data.is_dialog_already_done(dialog_id)

func add_dialog(character_id: String, dialog_id: String) -> void:
	data.add_dialog(character_id, dialog_id)
	
func set_dialog_already_done(dialog_id: String) -> void:
	data.set_dialog_already_done(dialog_id)

