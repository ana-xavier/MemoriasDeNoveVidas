extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite: Sprite2D = $Sprite 
@onready var player_node = get_parent().get_node("MainCharacter")

@export_category("Character")
@export var character_id: int = -1
@export var character_name: String = "???"
@export var texture: Texture2D = null
@export var frame: int = 50

@export_category("Dialogs")
@export var character_dialogs: Array[Dialog] = []
@export var character_idle_dialog: Dialog = null

enum Character {
	PLAYER,
	NPC
}

func _ready() -> void:
	self.scale = Vector2(0.6, 0.6)
	interaction_area.interact = Callable(self, "_on_interact")
	if texture != null:
		sprite.texture = texture
		sprite.frame = frame


func _on_interact():	
	await verify_current_quest()
	await manage_dialog()


func verify_current_quest() -> void:
	var current_quest = QuestManager.get_quest_by_character(character_id)
	if current_quest:
		var required_item_id = current_quest["required_item_id"]
		if InventoryManager.has_item(required_item_id):
			InventoryManager.remove_item(required_item_id)
			QuestManager.complete_quest(current_quest["id"])
			DialogData.add_dialog(character_id, current_quest["quest_complete_dialog"])


func manage_dialog() -> void:
	var dialog_data: Dialog = get_current_dialog()
	var dialog_boxes: Array[DialogBox] = dialog_data.dialog
		
	var curr_character
	var curr_position
	var curr_lines

	for dialog in dialog_boxes:
		if dialog.character_type == Character.NPC:
			curr_position = global_position
			curr_character = character_name
		else:
			curr_position = player_node.global_position
			curr_character = "Gatinho"	
		curr_lines =  dialog.lines
		
		DialogManager.start_dialog(curr_position, curr_lines, curr_character)
		await DialogManager.dialog_finished

	DialogData.remove_dialog(dialog_data.id)
	search_dialog_quest(dialog_data)


func get_current_dialog() -> Dialog:
	var dialog_id: String = DialogData.get_curr_dialog_by_character_id(character_id)
	for dialog in character_dialogs:
		if dialog.id == dialog_id:
			return dialog
	return character_idle_dialog	


func search_dialog_quest(dialogue_data: Dialog) -> void:
	if dialogue_data.release_a_quest:
		var quest_id = dialogue_data.quest_id 
		QuestManager.set_active_quest(quest_id)


