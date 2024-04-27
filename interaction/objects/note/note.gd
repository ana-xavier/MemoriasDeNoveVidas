extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var note_popup = get_tree().get_first_node_in_group("NotePopup")

@export var id: int = 0
@export var note_name: String = "" 
@export var note_text: String = ""

func init(_id, _note_name, _note_text, _position):
	id = _id
	note_name = _note_name
	note_text = _note_text
	position = _position

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	note_popup.close_note_popup()

func _on_interact():
	note_popup.set_note_text(note_text)
	note_popup.show_note_popup()
	await note_popup.closed_note
	DataManager.save_note_state(id, true)
	queue_free()
