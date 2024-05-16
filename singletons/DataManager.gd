extends Node

var _save: SaveData

func _ready():
	create_or_load_save()

func create_or_load_save() -> void:
	if SaveData.save_exists():
		_save = SaveData.load_save_data()
	else:
		_save = SaveData.new()
		# Add below all the data that have to come with the creation of the save.
		_save.quest_list.quests = QuestManager.load_quests_resource()
		_save.dialog_ready_list.add_dialog("srpotatoe", "srpotatoe_greetings")
		
		_save.write_save_data()

	# After creating or loading a save resource, dispatch its data to all singletons
	# that neet it.
	InventoryManager.data = _save.player_inventory
	InteractiveObjectsData.data = _save.interactive_objects_dict
	DialogData.data = _save.dialog_ready_list
	QuestManager.data = _save.quest_list
	

func save_game_data() -> void:
	_save.write_save_data()	

