extends Control

@onready var label: Label = $MarginContainer/TextContainer/Text
@onready var cancel_button: TextureButton = $MarginContainer/Buttons/HBoxContainer/CancelButton
@onready var confirm_button: TextureButton = $MarginContainer/Buttons/HBoxContainer/ConfirmButton
@onready var container: MarginContainer = $MarginContainer

const anim_duration: float = 0.3
var final_scale: Vector2 = Vector2.ZERO
var is_open: bool = false

func _ready():
	visible = false
	SignalBus.open_feedback_container.connect(self.open)

func open(text: String, show_cancel: bool, show_confirm: bool) -> void:
	if !show_cancel:
		cancel_button.visible = false
	if !show_confirm:
		confirm_button.visible = false
	label.text = text
	visible = true
	is_open = true
	_animate()
	
func _animate() -> void:
	final_scale = container.scale
	container.scale = Vector2.ZERO
	var tween = create_tween()
	tween.tween_property(
		container, "scale", final_scale, anim_duration
	).set_trans(Tween.TRANS_BACK)

func close() -> void:
	visible = false
	is_open = false
	cancel_button.visible = true
	confirm_button.visible = true

func _on_cancel_button_pressed():
	SignalBus.feedback_returned.emit("cancel")
	close()
	
func _on_confirm_button_pressed():
	SignalBus.feedback_returned.emit("confirm")
	close()
