extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player_node = get_parent().get_node("MainCharacter")

var character_id: int = 1
var character_name: String = "Mr. Fresh"

enum Character {
	PLAYER,
	NPC
}

func _ready() -> void:
	self.scale = Vector2(0.6, 0.6)
	interaction_area.interact = Callable(self, "_on_interact")

func get_dialog_lines():
	pass
	
func _on_interact():
	var dialogues_data = DialogData.get_character_dialog(character_id)
	var curr_position
	var curr_dialogue
	var curr_character

	for dialogue in dialogues_data:
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
