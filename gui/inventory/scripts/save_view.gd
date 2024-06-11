extends Control

@onready var save_content: RichTextLabel = $TextureRect/SaveContent

func search_saved_data():
	save_content.text = ""
	var text: String = ""
	var save = SaveManager.get_current_save_data(SaveManager.current_slot) as SaveData
	if save:
		text += "Dados salvos em Slot " + str(SaveManager.current_slot) + "\n"
		text += "Local: " + save.global_variables.display_level_name + "\n"
		var time: Dictionary = save.global_variables.last_time_saved
		if !time.is_empty():
			text += "Data: " + "%02d/%02d/%d\n" % [time.day, time.month, time.year]
			text += "Hora: " + "%02d:%02d\n" % [time.hour, time.minute]
		text += "Progresso: " + "[TO DO]\n"
		text += "Itens Secretos: " + "0/0"
		save_content.text = text
		
func save_progress():
	SaveManager.save_game_data(SaveManager.current_slot)	
	
func _on_save_data_button_pressed():
	SignalBus.open_feedback_container.emit("O progresso foi salvo com sucesso!", false, true)
	
	save_progress()
	search_saved_data()
