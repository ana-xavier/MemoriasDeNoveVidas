extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite: Sprite2D = $Sprite 
@onready var player_node = get_parent().get_node("MainCharacter")

@export_category("Character")
@export var character_id: int = -1
@export var character_name: String = "Gato"
@export var texture: Texture2D = null
@export var frame: int = 50

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

func manage_dialog():
	var dialogue_data = DialogData.get_character_dialog(character_id)
	var dialogue_lines = dialogue_data["dialog"]
	
	var curr_position
	var curr_dialogue
	var curr_character

	for dialogue in dialogue_lines:
		if dialogue["character_type"] == Character.NPC:
			curr_position = global_position
			curr_character = character_name
		else:
			curr_position = player_node.global_position
			curr_character = "Gatinho"	
		curr_dialogue =  dialogue["lines"]
		
		DialogManager.start_dialog(curr_position, curr_dialogue, curr_character)
		await DialogManager.dialog_finished

	DialogData.set_dialog_done(character_id)
	
	search_dialog_quest(dialogue_data)

func search_dialog_quest(dialogue_data):
	if dialogue_data["release_a_quest"]:
		var quest_id = dialogue_data["quest_id"]
		QuestManager.set_active_quest(quest_id)

func verify_current_quest():
	var current_quest = QuestManager.get_quest_by_character(character_id)
	if current_quest:
		var required_item_id = current_quest["required_item_id"]
		if PlayerInventory.has_item(required_item_id):
			PlayerInventory.remove_item(required_item_id)
			QuestManager.complete_quest(current_quest["id"])
			DialogData.set_dialog_ready(character_id)


	
