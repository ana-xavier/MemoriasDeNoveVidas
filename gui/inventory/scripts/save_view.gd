extends Control

@onready var save_content: RichTextLabel = $TextureRect/SaveContent

func search_saved_data():
	save_content.text = ""
	var text: String = ""
	var save = SaveManager.get_current_save_data() as SaveData
	if save:
		text += "Dados salvos em Slot 1\n"
		text += "Local: " + save.global_variables.display_level_name + "\n"
		text += "Data: " + "[TO DO]\n" 
		text += "Hora: " + "[TO DO]\n"
		text += "Progresso: " + "[TO DO]\n"
		text += "Itens Secretos: " + "0/0"
		save_content.text = text
		
func save_progress():
	SaveManager.save_game_data()	
	
func _on_save_data_button_pressed():
	save_progress()
	search_saved_data()
