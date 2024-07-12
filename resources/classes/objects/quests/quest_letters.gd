extends QuestCharactersInteract
class_name QuestLetters

@export var character_trigger_id: String
@export var letters_id: Array[String]
@export var finish_objective_display: String = ""

func check_and_complete_quest() -> void:
	if interacted_count == to_interact:
		super()

func add_character_interacted(character_id: String) -> void:
	if character_id ==  character_trigger_id:
		check_and_complete_quest()
	if characters_already_interacted.has(character_id):
		if !characters_already_interacted.get(character_id):
			characters_already_interacted[character_id] = true
			interacted_count += 1

func on_going_quest_tostring() -> String:
	var result: String = ""
	result += name + ":\n"
	
	var objective: String = str(interacted_count) + "/" + str(to_interact) + " " + objective_display + "\n"
	if to_interact == interacted_count:
		result += set_checkbox_checked(objective)
	else:
		result += set_checkbox(objective)
		
	result += set_checkbox(finish_objective_display) + "\n"
	
	return result

func on_quest_active() -> void:
	for letter_id in letters_id:
		InventoryManager.add_item(letter_id)
		
