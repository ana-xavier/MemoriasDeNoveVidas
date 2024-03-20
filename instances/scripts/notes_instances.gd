extends Node2D

var note_scene = preload("res://interaction/objects/note/note.tscn")

var notes_data = [
		{"id": 1, "position": Vector2(-54, -342), "text": "Nota 1"},
		{"id": 2, "position": Vector2(-513, -264), "text": "Nota 2"},
		{"id": 3, "position": Vector2(-207, -388), "text": "Nota 3"},
		{"id": 4, "position": Vector2(640, -304), "text": "Nota 4"},
		{"id": 5, "position": Vector2(475, 315), "text": "Nota 5"}
		]

func instantiate_notes():
	for note in notes_data:
		var note_instance = note_scene.instantiate()
		note_instance.init(note["id"], note["text"], note["position"])
		add_child(note_instance)

func _ready():
	instantiate_notes()
