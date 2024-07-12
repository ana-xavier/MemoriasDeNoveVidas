extends Node

var _save: SaveData
var current_slot: int = 1

func _ready():
	create_or_load_save(current_slot)

func create_new_save(slot: int) -> void:
	current_slot = slot
	create_save(slot)
	dispatch_data()

func create_or_load_save(slot: int) -> void:
	current_slot = slot
	if SaveData.save_exists(slot):
		_save = SaveData.load_save_data(slot)
	else:
		create_save(slot)
		
	dispatch_data()

func load_save_and_level(slot: int) -> void:
	if SaveData.save_exists(slot):
		_save = SaveData.load_save_data(slot)
		current_slot = slot
	else: return 
	
	var level_tag: String = _save.global_variables.current_level
	var door_tag: String = ""
	match level_tag:
		"level_1":
			door_tag = "MAIN_HOUSE_OUT"
		"house":
			door_tag = "INSIDE"
		"house_3_firstfloor":
			door_tag = "INSIDE"	
		"house_3_secondfloor":
			door_tag = "INSIDE_2"
		"forest":
			door_tag = "INSIDE"
		"forest_house":
			door_tag = "INSIDE"	
		"level_2":
			door_tag = "ENTRANCE"
			
	dispatch_data()
	if door_tag:
		NavigationManager.go_to_level(level_tag, door_tag)

func create_save(slot: int) -> void:
	_save = SaveData.new()
	# Add below all the data that have to come with the creation of the save.
	_save.quest_list.quests = QuestManager.load_quests_resource()
	_save.dialog_ready_list.add_dialog("srpotatoe", "srpotatoe_greetings")
	_save.dialog_ready_list.add_dialog("roma", "roma_greetings")
	_save.interactive_objects_dict.set_value_in_object("house_3_door", "door_locked", true)	
	_save.interactive_objects_dict.set_value_in_object("house_3_window", "door_locked", true)	
	_save.interactive_objects_dict.set_value_in_object("forest_entrance", "door_locked", true)	
	
	_save.global_variables.current_level = "house"
	_save.global_variables.display_level_name = "Casa de Misty"
	
	_save.write_save_data(slot)

func dispatch_data() -> void:
	# After creating or loading a save resource, dispatch its data to all singletons
	# that need it.
	GlobalData.data = _save.global_variables
	InventoryManager.data = _save.player_inventory
	InteractiveObjectsData.data = _save.interactive_objects_dict
	DialogData.data = _save.dialog_ready_list
	QuestManager.data = _save.quest_list

func save_game_data(slot: int) -> void:
	if !_save.already_saved:
		_save.already_saved = true
	_save.global_variables.last_time_saved = Time.get_datetime_dict_from_system()
	_save.write_save_data(slot)

func get_current_save_data(slot: int) -> SaveData:
	if SaveData.save_exists(slot):
		return SaveData.load_save_data(slot)
	return null
