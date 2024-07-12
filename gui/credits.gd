extends Control

const scene_to_load = preload("res://gui/mainmenu/main_menu.tscn")
@onready var game_logo_and_info: Control = $ColorRect/GameLogoAndInfo

func _ready():
	game_logo_and_info.modulate.a = 0.0
	animate()

func animate():
	var tween = create_tween().tween_property(
		game_logo_and_info, "modulate:a", 1.0, 3.0
	)
	await tween.finished
	await get_tree().create_timer(10.0).timeout
	get_tree().change_scene_to_packed(scene_to_load)
