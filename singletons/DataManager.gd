extends Node

const SAVE_DATA_PATH: String = "res://resources/save/save_data.tres"
const OBJECTS_STATES_DATA_PATH: String = "res://resources/data/interactive_objects_dict.tres"
const DIALOGS_READY_DATA_PATH: String = "res://resources/data/dialog_ready_list.tres"
const QUESTS_DATA_PATH: String = "res://resources/data/quest_list.tres" 

var save_data: SaveData = null

func create_new_save() -> void:
	save_data = SaveData.new()
	save_data.player_inventory = PlayerInventory.new()
	
	save_data.interactive_objects_dict = InteractiveObjectsDict.new()
	var objects_states_data = load(OBJECTS_STATES_DATA_PATH) as InteractiveObjectsDict
	save_data.interactive_objects_dict.objects_states = objects_states_data.objects_states
	
	save_data.dialog_ready_list = DialogReadyList.new()
	var dialogs_ready_data = load(DIALOGS_READY_DATA_PATH) as DialogReadyList
	save_data.dialog_ready_list.dialogs_ready = dialogs_ready_data.dialogs_ready
	
	save_data.quest_list = QuestList.new()
	var quests_data = load(QUESTS_DATA_PATH) as QuestList
	save_data.quest_list.quests = quests_data.quests
	
	ResourceSaver.save(save_data, SAVE_DATA_PATH)

func save_player_inventory(inventory: PlayerInventory) -> void:
	if (save_data == null):
		return
	save_data.player_inventory.quest_items = inventory.quest_items
	ResourceSaver.save(save_data, SAVE_DATA_PATH)

func save_interactive_objects_states(interactive_objects_dict: InteractiveObjectsDict) -> void:
	if (save_data == null):
		return
	save_data.interactive_objects_dict.objects_states = interactive_objects_dict.objects_states
	ResourceSaver.save(save_data, SAVE_DATA_PATH)

func save_dialogs_ready(dialogs_ready: Array[DialogReady]) -> void:
	if (save_data == null):
		return
	save_data.dialog_ready_list.dialogs_ready = dialogs_ready
	ResourceSaver.save(save_data, SAVE_DATA_PATH)

func save_quests_status(quests: Array[Quest]):
	if (save_data == null):
		return
	save_data.quest_list.quests = quests
	ResourceSaver.save(save_data, SAVE_DATA_PATH)

func load_save() -> void: 
	if ResourceLoader.exists(SAVE_DATA_PATH):
		var data = ResourceLoader.load(SAVE_DATA_PATH)
		if data is SaveData: 
			save_data = data		

func load_interactive_objects_states() -> InteractiveObjectsDict:
	if (save_data == null):
		load_save()
	if (save_data != null):
		return save_data.interactive_objects_dict
	return null

func load_player_inventory_data() -> PlayerInventory:
	if (save_data == null):
		load_save()
	if (save_data != null):
		return save_data.player_inventory
	return null

func load_dialogs_ready_data() -> DialogReadyList:
	if (save_data == null):
		load_save()
	if (save_data != null):
		return save_data.dialog_ready_list
	return null

func load_quests_status() -> QuestList:
	if (save_data == null):
		load_save()
	if (save_data != null):
		return save_data.quest_list
	return null
