extends VBoxContainer

const button_scene = preload("res://gui/components/scenes/data_button.tscn")

var has_saved_data: bool = false

func _ready():
	for slot in range(1, 4):  
		var save = SaveManager.get_current_save_data(slot) as SaveData
		if save && save.already_saved:
			has_saved_data = true

func open() -> void:
	await _update_slots()

func _update_slots() -> void:
	clear_buttons()
	
	for slot in range(1, 4):  
		
		var save = SaveManager.get_current_save_data(slot) as SaveData
		if save:
			if save.already_saved:
				var button_instance = button_scene.instantiate()
				button_instance.pressed.connect(_on_slot_pressed.bind(slot))
				add_child(button_instance)
				button_instance.set_text(get_save_content(save))

func clear_buttons() -> void:
	for child in get_children():
		child.queue_free()
				
func get_save_content(save: SaveData) -> String:
	var content: String = save.global_variables.display_level_name + "\n"
	var time: Dictionary = save.global_variables.last_time_saved
	if !time.is_empty():
		content += "%02d/%02d/%d - %02d:%02d\n" % [time.day, time.month, time.year, time.hour, time.minute]
	content += QuestManager.get_progress_by_save(save)
	return content
	
func _on_slot_pressed(slot: int) -> void:
	SignalBus.loading_level.emit()
	SaveManager.load_save_and_level(slot)
