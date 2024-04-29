extends Resource
class_name DialogReadyList

@export var dialogs_ready: Array[DialogReady] = []

func get_curr_dialog_by_character_id(character_id: int ) -> String:
	for dialog in dialogs_ready:
		if dialog.character_id == character_id:
			return dialog.dialog_id
	return ""
	
func remove_dialog(dialog_id: String) -> void:
	for i in range(dialogs_ready.size()):
		if dialogs_ready[i].dialog_id == dialog_id:
			dialogs_ready.remove_at(i)
			return

func add_dialog(character_id: int, dialog_id: String) -> void:
	var dialog: DialogReady = DialogReady.new()
	dialog.character_id = character_id
	dialog.dialog_id = dialog_id
	dialogs_ready.append(dialog)	
