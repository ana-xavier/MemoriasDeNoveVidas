extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var note_popup = get_tree().get_first_node_in_group("NotePopup")

@export var id: String = ""
var note_name: String = "" 
var note_text: String = ""

func _ready():
	if (InteractiveObjectsData.is_object_already_interacted(id)):
		queue_free()
		
	var note_data = NotesData.get_note_by_id(id) as Note
	if (note_data != null):
		note_name = note_data.name
		note_text = note_data.text
		
	interaction_area.interact = Callable(self, "_on_interact")
	note_popup.close_note_popup()

func _on_interact():
	note_popup.set_note_text(note_text)
	note_popup.show_note_popup()
	await note_popup.closed_note
	InteractiveObjectsData.set_object_already_interacted(id)
	queue_free()
