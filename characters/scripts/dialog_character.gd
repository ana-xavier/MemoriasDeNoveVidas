extends BaseCharacter
class_name DialogCharacter

@onready var player_node = get_parent().get_node("MainCharacter")
@onready var interaction_area: InteractionArea = $InteractionArea

@export_category("Dialogs")
@export var character_dialogs: Array[Dialog] = []
@export var character_idle_dialog: Dialog = null

var curr_dialog_data: Dialog = null

enum Character {
	PLAYER,
	NPC
}

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	super()

func _on_interact():	
	await manage_dialog()

func manage_dialog() -> void:
	if !curr_dialog_data:
		curr_dialog_data = get_current_dialog()
		
	var dialog_boxes: Array[DialogBox] = curr_dialog_data.dialog

	for dialog in dialog_boxes:
		var curr_character = character_name if dialog.character_type == Character.NPC else "Gatinho"
		var curr_position =  global_position if dialog.character_type == Character.NPC else player_node.global_position
		var curr_lines: Array[String] =  dialog.lines
		
		DialogManager.start_dialog(curr_position, curr_lines, curr_character)
		await DialogManager.dialog_finished

	DialogData.set_dialog_already_done(curr_dialog_data.id)
	search_quest_in_dialog()
	curr_dialog_data = null


func get_current_dialog() -> Dialog:
	var dialog_id: String = DialogData.get_curr_dialog_by_character_id(character_id)
	
	for dialog in character_dialogs:
		if dialog.id == dialog_id:
			return dialog
	return character_idle_dialog	


func search_quest_in_dialog() -> void:
	if curr_dialog_data.release_a_quest:
		var quest_id = curr_dialog_data.quest_id
		QuestManager.set_quest_active(quest_id) 
