extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_note_manager_closed_note():
	get_tree().paused = false


func _on_note_manager_opened_note():
	get_tree().paused = true
