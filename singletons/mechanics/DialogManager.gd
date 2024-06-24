extends Node

@onready var text_box_scene = preload("res://gui/textbox/text_box.tscn")

var character_name: String

var dialog_lines = []
var current_line_index = 0

var text_box
var text_box_position: Vector2

var is_dialog_active: bool = false
var can_advance_line: bool = false
var is_dialog_automatic: bool = false
var is_name_hided: bool = false
var name_character_color: String = ""

#signal dialog_started()
signal dialog_finished()

func start_dialog(position: Vector2, lines, _name: String, hide_name:bool = false, automatic: bool = false, name_color: String = ""):
	if is_dialog_active:
		return
	
	text_box_position = position
	dialog_lines = lines
	character_name = _name
	is_name_hided = hide_name
	is_dialog_automatic = automatic
	name_character_color = name_color
	
	_show_text_box()
	
	is_dialog_active = true
	
func _show_text_box():
	text_box = text_box_scene.instantiate()
	text_box.set_character_name(character_name)
	text_box.finished_displaying.connect(_on_text_box_finished_displaying)
	get_tree().root.add_child(text_box)
	text_box.global_position = text_box_position
	text_box.display_text(dialog_lines[current_line_index], name_character_color)
	can_advance_line = false
	
func _on_text_box_finished_displaying():
	can_advance_line = true
	if is_dialog_automatic:
		handle_next_line()

func _unhandled_input(event):
	if(event.is_action_pressed("advance_dialog") && !is_dialog_automatic && is_dialog_active && can_advance_line):
		handle_next_line()

func handle_next_line():
	text_box.queue_free()
		
	current_line_index += 1
	if current_line_index >= dialog_lines.size():
		is_dialog_active = false
		is_dialog_automatic = false
		is_name_hided = false
		current_line_index = 0
		dialog_finished.emit()
		return 
			
	_show_text_box()
