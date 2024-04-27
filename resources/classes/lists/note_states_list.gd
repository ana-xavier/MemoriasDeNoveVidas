extends Resource
class_name NoteStatesList

@export var note_states: Array[NoteState] = []

func set_note_state(id: int, already_get: bool) -> void:
	for note in note_states:
		if (note.note_id == id):
			print("Mudou o estado da nota:")
			print(id)
			note.already_get = already_get
			return

func already_get_note(id: int) -> bool:
	for note in note_states:
		if (note.note_id == id):
			return note.already_get
	return false		
