extends MarginContainer

@onready var label = $MarginContainer/Label
@onready var timer = $ShowLetterTimer

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
	self.scale = Vector2(0.5, 0.5)
	
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
		
	global_position.x -= ((size.x / 2) * scale.x)
	global_position.y -= (size.y + 36) * scale.y
	
	label.text = character_name
	label.text += ":\n"
	
	_display_letter()
	
func _display_letter():
	label.text += text[letter_index]
	
	letter_index += 1
	if letter_index >= text.length():
		finished_displaying.emit()
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
