extends Quest
class_name QuestCharactersInteract

@export var interacted_count: int = 0
@export var to_interact: int = 0 
@export var characters_already_interacted: Dictionary = {}

func check_and_complete_quest() -> void:
	if interacted_count == to_interact:
		super()

func add_character_interacted(character_id: String) -> void:
	if characters_already_interacted.has(character_id):
		if !characters_already_interacted.get(character_id):
			characters_already_interacted[character_id] = true
			interacted_count += 1
			check_and_complete_quest()
