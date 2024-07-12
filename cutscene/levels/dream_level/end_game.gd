extends Cutscene

const credits = preload("res://gui/credits.tscn")
@export var white_screen: ColorRect = null
@export var music: AudioStreamPlayer = null

func prerequisites() -> bool:
	return true
	
func run() -> void:
	
	var tween = create_tween().tween_property(
		white_screen, "color:a", 1.0, 2.0
	)
	var tween2 = create_tween().tween_property(
		music, "volume_db", -80, 2.0
	)
	
	await get_tree().create_timer(3.0).timeout
	
	get_tree().change_scene_to_packed(credits)
