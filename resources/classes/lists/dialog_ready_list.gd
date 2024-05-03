extends Resource
class_name DialogReadyList

@export var dialogs_ready: Array[DialogReady] = []

func get_curr_dialog_by_character_id(character_id: String ) -> String:
	for dialog in dialogs_ready:
		if (dialog.character_id == character_id && !dialog.is_already_done):
			return dialog.dialog_id
	return ""

func is_dialog_already_done(dialog_id: String) -> bool:
	for dialog in dialogs_ready:
		if dialog.dialog_id == dialog_id:
			return dialog.is_already_done
	return false
	
func set_dialog_already_done(dialog_id: String) -> void:
	if !dialog_id:
		return
		
	for dialog in dialogs_ready:
		if dialog.dialog_id == dialog_id:
			dialog.is_already_done = true
			return 
	var dialog: DialogReady = DialogReady.new()
	dialog.dialog_id = dialog_id
	dialog.is_already_done = true
	dialogs_ready.append(dialog)	
	
func add_dialog(character_id: String, dialog_id: String) -> void:
	var dialog: DialogReady = DialogReady.new()
	dialog.character_id = character_id
	dialog.dialog_id = dialog_id
	dialogs_ready.append(dialog)	
