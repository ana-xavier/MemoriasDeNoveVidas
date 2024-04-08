extends MarginContainer

@onready var label = $MarginContainer/Label
@onready var timer = $ShowLetterTimer
@onready var next_indicator = $NinePatchRect/Control2/NextIndicator

const MAX_WIDTH = 256

var character_name = ""
var text = ""
var letter_index = 0

var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2

var default_color = Color(0, 0, 0, 1.0) # Default Color (black)
var gray_color = Color(0.5, 0.5, 0.5, 1.0) # Gray


signal finished_displaying()

func _ready():
	scale = Vector2(0.2, 0.2)
	
func set_character_name(_name: String):
	character_name = _name

func display_text(text_to_display: String):
	text = text_to_display
	label.text = text_to_display
	
	await resized
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		custom_minimum_size.y = size.y
		
	global_position.x -= (size.x / 2) * 0.5
	global_position.y -= (size.y + 36) * 0.5
	
	label.text = character_name
	label.text += ":\n"
	
	#pivot_offset = Vector2((size.x / 2), size.y)
	
	var tween = get_tree().create_tween()
	tween.tween_property(
		self, "scale", Vector2(0.5, 0.5), 0.15
	).set_trans(Tween.TRANS_BACK)
	
	_display_letter()
	
func _display_letter():
	label.text += text[letter_index]
	
	letter_index += 1
	if letter_index >= text.length():
		finished_displaying.emit()
		next_indicator.visible = true
		return
		
	match text[letter_index]:
		"!", "?", ".", ",":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time)
	


func _on_show_letter_timer_timeout():
	_display_letter()
