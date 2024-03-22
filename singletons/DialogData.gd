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

var mrfresh_character = {
	"id": 1,
	"name": "Mr. Fresh",
	"character_idle_dialog": [
		{"character_type": Character.NPC, 
			"lines": [
				"Meow!"
		]}],
	"character_dialogs": [
		{
			"id": 1,
			"is_dialog_done": false,
			"is_dialog_ready": true,
			"dialog": [
				{"character_type": Character.PLAYER, 
					"lines": [
					"Oiii Mr.Fresh! Faz tempo que nao te vejo.",
					"Como voce esta? Estava bem doente da ultima vez em que te vi..."
				]},
				{"character_type": Character.NPC, 
					"lines": [
					"Ola! Estou otimo!",
					"Melhorei do dia pra noite, como em um piscar de olhos."
				]},
				{"character_type": Character.PLAYER, 
					"lines": [
					"Ei, por acaso voce viu meus donos por ai?.",
					"Estou preocupado, faz um dia inteiro que nao os vejo."
				]}
			]
		},
		{
			"id": 2,
			"is_dialog_done": false,
			"is_dialog_ready": false,
			"dialog": []
		}
	]
}

func _ready():
	characters_data.append(mrfresh_character)
	
func get_character_dialog(character_id: int):
	var character = get_character(character_id)
	var character_dialogs = character["character_dialogs"]
	
	for dialog_data in character_dialogs:
		if(!dialog_data["is_dialog_done"] && dialog_data["is_dialog_ready"]):
			return dialog_data["dialog"]
			
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
	
