extends Control

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/scenes/house.tscn")
	DataManager.create_new_save()
	Transition.transition_menu()

#func _on_controls_pressed() -> void:
	#get_tree().change_scene_to_file("res://character/scenes/controls.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
