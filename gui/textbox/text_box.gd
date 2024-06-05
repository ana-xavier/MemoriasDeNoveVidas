extends MarginContainer

@onready var label = $MarginContainer/RichTextLabel
@onready var timer = $ShowLetterTimer
@onready var display_timer = $DisplayTimer
@onready var next_indicator = $NinePatchRect/Control2/NextIndicator

const MAX_WIDTH = 256
const TIME_PER_CHARACTER = 0.02
const DISPLAY_NAME_COLOR = "[color=purple]"

var initial_scale: Vector2 

var character_name = ""
var text = ""
var letter_index = 0

var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2

var default_color = Color(0, 0, 0, 1.0) # Default Color (black)
var gray_color = Color(0.5, 0.5, 0.5, 1.0) # Gray

var advance_dialog: bool = false

signal finished_displaying()

func _ready():
	initial_scale = scale
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
		
	global_position.x -= (size.x / 2) * initial_scale.x
	global_position.y -= (size.y + 36) * initial_scale.y
	
	if DialogManager.is_name_hided:
		label.text = ""
	else:
		label.text = DISPLAY_NAME_COLOR + character_name + "[/color]"
		label.text += ":\n"
	
	#pivot_offset = Vector2((size.x / 2) * 0.5, size.y * 0.5)
	
	var tween = get_tree().create_tween()
	tween.tween_property(
		self, "scale", initial_scale, 0.15
	).set_trans(Tween.TRANS_BACK)
	
	_display_letter()


func add_bb_code():
	var closed_bracket_index: int = text.find("]", letter_index)
	if closed_bracket_index != -1:
		var length = closed_bracket_index - letter_index + 1
		label.text += text.substr(letter_index, length)
		letter_index = closed_bracket_index
	
func _display_letter():
	if text[letter_index] == "[":
		await add_bb_code()
	else:	
		label.text += text[letter_index]
	letter_index += 1
	
	if advance_dialog:
		label.text += text.substr(letter_index, text.length() -1)
		advance_dialog = false
		letter_index = text.length()
		
	if letter_index >= text.length():
		if DialogManager.is_dialog_automatic:
			display_timer.wait_time = calculate_display_time()
			display_timer.start()
			await display_timer.timeout
		else:
			next_indicator.visible = true
			
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

func _input(event):
	if event.is_action_pressed("advance_dialog") && !DialogManager.is_dialog_automatic:
		advance_dialog = true

func calculate_display_time():
	var num_characters = text.length()
	return num_characters * TIME_PER_CHARACTER
