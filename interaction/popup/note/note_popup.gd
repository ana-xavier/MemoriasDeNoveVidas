extends Control

@onready var label = $NoteTexture/Text
var is_open: bool = false

signal opened_note()
signal closed_note()

func _ready():
	visible = false

func set_note_text(text) -> void:
	label.text = text

func show_note_popup() -> void:
	visible = true
	is_open = true
	opened_note.emit()

func close_note_popup() -> void:
	visible = false
	is_open = false
	closed_note.emit()
		
func _on_close_button_pressed():
	close_note_popup()
