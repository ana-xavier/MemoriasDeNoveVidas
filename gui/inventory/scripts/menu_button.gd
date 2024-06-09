extends TextureButton

const hover_scale = Vector2(1.05, 1.05)
const original_scale = Vector2(1, 1)

@onready var hover: AudioStreamPlayer = $HoverSound
@onready var click: AudioStreamPlayer = $ClickSound

func _on_mouse_entered():
	scale = hover_scale
	position.x = position.x - 2
	hover.play()

func _on_mouse_exited():
	scale = original_scale
	position.x = position.x + 2

func _on_pressed():
	click.play()
