extends Area2D

const scene_text_2 = preload("res://transition/text_scene/text_scene_2.tscn")

func _on_body_entered(body):
	if body is MainCharacter:
		get_tree().change_scene_to_packed(scene_text_2)
