extends Node

const data: NotesList = preload("res://resources/data/notes_list.tres")

func get_note_by_id(note_id: String) -> Note:
	return data.get_note_by_id(note_id)
