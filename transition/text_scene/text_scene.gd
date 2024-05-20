extends Control

@onready var timer: Timer = $Timer
@onready var color_rect: ColorRect = $ColorRect

const scene_house = preload("res://levels/scenes/house.tscn")

func _ready():
	timer.start()
	fade_in()

func _on_timer_timeout():
	fade_out()

func fade_in():
	color_rect.modulate = Color(1, 1, 1, 0)
	
	var tween = get_tree().create_tween()
	tween.tween_property(
		color_rect, "modulate", Color(1, 1, 1, 1), 4.0
	).set_trans(Tween.TRANS_LINEAR)

func fade_out():
	var tween = get_tree().create_tween()
	tween.tween_property(
		color_rect, "modulate", Color(1, 1, 1, 0), 2.0
	).set_trans(Tween.TRANS_LINEAR).finished.emit()
	
	await tween.finished
	change_scene()
	
func change_scene():
	get_tree().change_scene_to_packed(scene_house)
	
	
