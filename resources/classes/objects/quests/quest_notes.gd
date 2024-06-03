extends Quest
class_name QuestNotes

@export var notes_count: int = 0
@export var notes_to_get: int = 0

func check_and_complete_quest() -> void:
	if notes_count == notes_to_get:
		super()

func add_note_obtained() -> void:
	notes_count += 1
	check_and_complete_quest()

func on_going_quest_tostring() -> String:
	var result: String = ""
	result += name + ":\n"
	
	var objective: String = str(notes_count) + "/" + str(notes_to_get) + " " + objective_display + "\n"
	result += set_checkbox(objective) + "\n"
	return result
