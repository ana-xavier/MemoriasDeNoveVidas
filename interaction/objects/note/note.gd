extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var note_manager = get_tree().get_first_node_in_group("NoteManager")

var note_text = "Testando..."

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	note_manager.close_note_popup()

func _on_interact():
	note_manager.set_note_text(note_text)
	note_manager.show_note_popup()
	await note_manager.closed_note
