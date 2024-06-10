extends TextureButton

const hover_scale = Vector2(1.05, 1.05)
const original_scale = Vector2(1, 1)

@onready var label: Label = $Label

var is_slot_empty: bool = false

func set_text(text: String):
	label.text = text
	pass

func _on_mouse_entered():
	scale = hover_scale
	position.x = position.x - 2

func _on_mouse_exited():
	scale = original_scale
	position.x = position.x + 2


