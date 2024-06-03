@icon("res://gui/icons/editor/component_icon.png")
extends Node2D
class_name QuestComponent

@export var character: BaseCharacter = null
@export var dialog_component: DialogComponent = null
@export_category("External Quests")
@export var char_interact_quest_id: String = ""

func manage_character_quest() -> void:
	var quest = QuestManager.get_quest_by_character_id(character.character_id)
	if quest:
		quest.check_and_complete_quest()

func manage_characters_interact_quest():
	var quest = QuestManager.get_quest_by_id(char_interact_quest_id) as QuestCharactersInteract
	if quest:
		quest.add_character_interacted(character.character_id)

func get_current_dialog_by_quest_complete() -> Dialog:
	var dialogs: Array[Dialog] = dialog_component.character_dialogs
	for dialog in dialogs:
		if (dialog.has_prerequisite 
			&& QuestManager.is_quest_complete(dialog.prerequisite_quest_id)
			&& !DialogData.is_dialog_already_done(dialog.id)
			):
			return dialog
	return null
