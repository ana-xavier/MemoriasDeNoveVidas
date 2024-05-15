extends Control

@onready var label: Label = $MarginContainer/TextContainer/Text

const anim_duration: float = 0.3
var final_scale: Vector2 = Vector2.ZERO
var is_open: bool = false

func _ready():
	visible = false
	SignalBus.open_content_container.connect(self.open)

func open(text: String) -> void:
	label.text = text
	visible = true
	is_open = true
	_animate()
	SignalBus.opened_content_container.emit()
	
func _animate() -> void:
	final_scale = scale
	scale = Vector2.ZERO
	var tween = get_tree().create_tween()
	tween.tween_property(
		self, "scale", final_scale, anim_duration
	).set_trans(Tween.TRANS_BACK)

func close() -> void:
	visible = false
	is_open = false
	SignalBus.closed_content_container.emit()

func _input(event):
	if is_open && event.is_action_pressed("interact"):
		close()

func _on_close_button_pressed():
	close()
