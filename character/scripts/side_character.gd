extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player_node = get_parent().get_node("MainCharacter")

enum Character {
	PLAYER,
	NPC
}

var dialogues_data = [
	{"character_type": Character.PLAYER, "lines": [
		"Oiii Mr.Fresh! Faz tempo que nao te vejo.",
		"Como voce esta? Estava bem doente da ultima vez em que te vi..."
	]},
	{"character_type": Character.NPC, "lines": [
		"Ola! Estou otimo!",
		"Melhorei do dia pra noite, como em um piscar de olhos."
	]},
	{"character_type": Character.PLAYER, "lines": [
		"Ei, por acaso voce viu meus donos por ai?.",
		"Estou preocupado, faz um dia inteiro que nao os vejo."
	]}
]

func _ready() -> void:
	self.scale = Vector2(0.6, 0.6)
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	var curr_position
	for dialogue in dialogues_data:
		if dialogue["character_type"] == Character.NPC:
			curr_position = global_position
		else:
			curr_position = player_node.global_position
		var curr_dialogue =  dialogue["lines"]
		DialogManager.start_dialog(curr_position, curr_dialogue)
		await DialogManager.dialog_finished
