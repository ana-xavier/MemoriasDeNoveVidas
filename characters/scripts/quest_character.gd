extends DialogCharacter
class_name QuestCharacter

@export_category("External Quests")
@export var char_interact_quest_id: String = ""

func _on_interact():	
	manage_deliver_item_quest()
	manage_characters_interact_quest()
	curr_dialog_data = get_current_dialog_by_quest_complete()	
	await super()
	
	
	
func manage_deliver_item_quest() -> void:
	var quest = QuestManager.get_quest_by_character_id(character_id) as QuestDeliverItem
	if quest:
		quest.check_and_complete_quest()


func manage_characters_interact_quest():
	var quest = QuestManager.get_quest_by_id(char_interact_quest_id) as QuestCharactersInteract
	if quest:
		quest.add_character_interacted(character_id)


func get_current_dialog_by_quest_complete() -> Dialog:
	for dialog in character_dialogs:
		if (dialog.has_prerequisite 
			&& QuestManager.is_quest_complete(dialog.prerequisite_quest_id)
			&& !DialogData.is_dialog_already_done(dialog.id)
			):
			return dialog
	return null
	
	
