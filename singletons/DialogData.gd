extends Node

enum Character {
	PLAYER,
	NPC
}

var characters_data = []
	
# character_idle_dialog: Diálogo padrão caso não ouver diálogos disponíveis.
# is_dialog_done: se o diálogo já foi realizado entre o player e npc
# is_dialog_ready: se o diálogo está pronto para acontecer em determinado momento do jogo

# Observações: character_dialogs são armazenados cronologicamente, ou seja, dialogos marcados
# com is_dialog_done: false e is_dialog_ready: true serão priorizados na lista. O primeiro 
# encontrado com essas condições no Array será escolhido.

var mrpotatoe_character = {
	"id": 1,
	"name": "Sr. Batata",
	"character_idle_dialog": {
			"release_a_quest": false,
			"dialog": [
				{"character_type": Character.NPC, 
					"lines": [
						"Meow!      "
				]}]
		},
	"character_dialogs": [
		{
			"release_a_quest": true,
			"quest_id": "srpotatoe_item_quest",
			"is_dialog_done": false,
			"is_dialog_ready": true,
			"dialog": [
				{"character_type": Character.PLAYER, 
					"lines": [
					"Oiii Sr. Batata! Faz tempo que nao te vejo.",
					"Como voce esta? Estava bem doente da ultima vez em que te vi..."
				]},
				{"character_type": Character.NPC, 
					"lines": [
					"Ola! Estou otimo!",
					"Bla Bla Bla... voce poderia pegar meu Patinho de Borracha para mim?"
				]},
				{"character_type": Character.PLAYER, 
					"lines": [
					"Claro! Vou encontrar para voce!"
				]}
			]
		},
		{
			"id": 2,
			"release_a_quest": false,
			"is_dialog_done": false,
			"is_dialog_ready": false,
			"dialog": [
				{"character_type": Character.NPC, 
					"lines": [
					"Voce encontrou! :)",
					"Obrigado amigo, voce e um amigo!"
				]},
			]
		}
	]
}

func _ready():
	characters_data.append(mrpotatoe_character)
	
func get_character_dialog(character_id: int):
	var character = get_character(character_id)
	var character_dialogs = character["character_dialogs"]
	
	for dialog_data in character_dialogs:
		if(!dialog_data["is_dialog_done"] && dialog_data["is_dialog_ready"]):
			return dialog_data
			
	return character["character_idle_dialog"]

func get_character(character_id: int):
	for character in characters_data:
		if(character["id"] == character_id):
			return character

func set_dialog_done(character_id: int):
	for character in characters_data:
		if(character["id"] == character_id):
			var character_dialogs = character["character_dialogs"]
			
			for dialog_data in character_dialogs:
				if (!dialog_data["is_dialog_done"] && dialog_data["is_dialog_ready"]):
					dialog_data["is_dialog_done"] = true
					return
			return	

func set_dialog_ready(character_id: int):
	for character in characters_data:
		if character["id"] == character_id:
			var character_dialogs = character["character_dialogs"]
			
			for dialog_data in character_dialogs:
				if not dialog_data["is_dialog_done"] and not dialog_data["is_dialog_ready"]:
					dialog_data["is_dialog_ready"] = true
					return
			return
