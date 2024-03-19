extends Control

@onready var label = $TextureRect/Label
var isOpen: bool = false

signal opened_note()
signal closed_note()

func set_note_text(text):
	label.text = text

func show_note_popup():
	visible = true
	isOpen = true
	opened_note.emit()

func close_note_popup():
	visible = false
	isOpen = false
	closed_note.emit()
	
func _input(event):
	if event.is_action_pressed("interact") && isOpen:
		close_note_popup()
		
	
