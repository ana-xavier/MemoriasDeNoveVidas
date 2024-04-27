extends Resource
class_name NotesList

@export var notes: Array[Note] = []

func get_note_by_id(note_id: int) -> Note:
	for note in notes:
		if note.id == note_id:
			return note
	return null
