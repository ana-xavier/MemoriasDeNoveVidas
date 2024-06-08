extends Node

@onready var camera2D: Camera2D = $Camera2D

var transitioning: bool = false

signal transitioning_complete

func _ready() -> void:
	camera2D.enabled= false

func switch_camera(from, to) -> void:
	from.current = false
	to.current = true

func transition_camera2D(from: Camera2D, to: Camera2D, duration: float = 1.0) -> void:
	if transitioning: return
	# Copy the parameters of the first camera
	camera2D.zoom = from.zoom
	camera2D.offset = from.offset
	camera2D.light_mask = from.light_mask
	camera2D.global_position = from.global_position
	
	# Enable transitioning camera
	from.enabled = false
	camera2D.enabled = true
	transitioning = true
	
	var tween: Tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property(
		camera2D, "global_position", to.global_position, duration
		).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(
		camera2D, "zoom", to.zoom, duration
		).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(
		camera2D, "offset", to.offset, duration
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	
	await tween.finished
	
	# Enable target camera
	camera2D.enabled = false
	to.enabled = true
	transitioning = false
	
	transitioning_complete.emit()

