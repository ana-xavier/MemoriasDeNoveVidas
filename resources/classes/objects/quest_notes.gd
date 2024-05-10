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
