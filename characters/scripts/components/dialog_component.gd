@icon("res://gui/icons/editor/component_icon.png")
extends Node2D
class_name DialogComponent

enum Character {
	PLAYER,
	NPC
}

@export var character: CharacterBody2D = null
@export_category("Dialogs")
@export var character_idle_dialog: Dialog = null
@export var character_dialogs: Array[Dialog] = []
@export var text_box_y_offset: float = 0
@export var character_color_name: String = ""

const main_character_name_color: String = "[color=purple]"
var curr_dialog_data: Dialog = null


func manage_dialog(player_body: CharacterBody2D) -> void:
	if !curr_dialog_data:
		curr_dialog_data = get_current_dialog()
		
	var dialog_boxes: Array[DialogBox] = curr_dialog_data.dialog

	for dialog in dialog_boxes:
		var curr_lines: Array[String] =  dialog.lines
		var curr_character = character.character_name if dialog.character_type == Character.NPC else GlobalData.main_character_name
		var name_color: String = ""
		
		var curr_position: Vector2
		if dialog.character_type == Character.NPC:
			name_color = character_color_name
			curr_position =  character.global_position
			curr_position.y += text_box_y_offset
		else: 
			curr_position = player_body.global_position
			name_color = main_character_name_color
	
		DialogManager.start_dialog(curr_position, curr_lines, curr_character, false, false, name_color)
		await DialogManager.dialog_finished

	SignalBus.dialog_boxes_finished.emit()
	DialogData.set_dialog_already_done(curr_dialog_data.id)
	search_quest_in_dialog()
	curr_dialog_data = null


func get_current_dialog() -> Dialog:
	var dialog_id: String = DialogData.get_curr_dialog_by_character_id(character.character_id)
	
	for dialog in character_dialogs:
		if dialog.id == dialog_id:
			return dialog
	return character_idle_dialog	


func search_quest_in_dialog() -> void:
	if curr_dialog_data.release_a_quest:
		var quest_id = curr_dialog_data.quest_id
		QuestManager.set_quest_active(quest_id) 
