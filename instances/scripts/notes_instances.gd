extends Node2D

const data_path: String = "res://resources/data/note_states_list.tres"

var note_scene = preload("res://interaction/objects/note/note.tscn")
var note_states: Array[NoteState] = []

func instantiate_notes() -> void:
	for note_state in note_states:
		if (not note_state.already_get):
			var note: Note = NotesData.get_note_by_id(note_state.note_id)
			if (note != null):	
				if(note is Note):
					var note_instance = note_scene.instantiate()
					note_instance.init(note.id, note.name, note.text, note.position) 
					add_child(note_instance)

func load_data() -> Array[NoteState]:
	if ResourceLoader.exists(data_path):
		var data = ResourceLoader.load(data_path)
		if data is NoteStatesList: # Check that the data is valid
			return data.note_states
	return []
	
func _ready():
	var data: Array[NoteState] = DataManager.load_note_states_data()
	if (not data.is_empty()):
		note_states = data
	else:
		note_states = load_data()
	
	instantiate_notes()
