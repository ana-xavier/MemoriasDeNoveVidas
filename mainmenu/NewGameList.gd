extends VBoxContainer

var is_slots_empty: bool = false

var slot_already_saved = {}

func _ready():
	for slot in range(1, 4):  
		var button = get_child(slot - 1) as TextureButton
		button.pressed.connect(_on_slot_pressed.bind(slot))

func open() -> void:
	await _update_slots()

func _update_slots() -> void:
	for slot in range(1, 4):  
		var button = get_child(slot - 1) as TextureButton
		
		var save = SaveManager.get_current_save_data(slot) as SaveData
		if save:
			if slot == 1 && !save.already_saved:
				is_slots_empty = true
				return 
			button.set_text("[Slot " + str(slot) + "]")
			
			slot_already_saved[slot] = save.already_saved
		else:
			button.set_text("[Slot " + str(slot) + " - Vazio]")
		
	is_slots_empty = false
	
func get_save_content(save: SaveData) -> String:
	return ""
	
func _on_slot_pressed(slot: int) -> void:
	if slot_already_saved.get(slot):
		SignalBus.open_feedback_container.emit("Você tem certeza que deseja sobrescrever\nos dados salvos em Slot " + str(slot) + "?", true, true)
		var message: String = await SignalBus.feedback_returned
		if message == "cancel":
			return
	get_tree().change_scene_to_file("res://transition/text_scene/text_scene.tscn")
	SaveManager.create_new_save(slot)
	Transition.transition_menu()
