extends Node

const SAVE_DATA_PATH: String = "res://resources/save/save_data.tres"
const DIGGING_DATA_PATH: String = "res://resources/data/digging_areas_list.tres"
const NOTES_STATES_DATA_PATH: String = "res://resources/data/note_states_list.tres"

var save_data: SaveData = null

func create_new_save() -> void:
	save_data = SaveData.new()
	save_data.player_inventory = PlayerInventory.new()
	
	save_data.digging_areas_list = DiggingAreasList.new()
	var digging_data: DiggingAreasList = load(DIGGING_DATA_PATH)
	if (digging_data is DiggingAreasList):
		save_data.digging_areas_list.digging_areas = digging_data.digging_areas
	
	save_data.note_states_list = NoteStatesList.new()
	var notes_states_data = load(NOTES_STATES_DATA_PATH)
	if (notes_states_data is NoteStatesList):
		save_data.note_states_list.note_states = notes_states_data.note_states
	
	ResourceSaver.save(save_data, SAVE_DATA_PATH)

func save_player_inventory(inventory: PlayerInventory) -> void:
	if (save_data == null):
		return
	save_data.player_inventory = inventory
	ResourceSaver.save(save_data, SAVE_DATA_PATH)

func save_digging_area_state(area_id: int, already_dug: bool) -> void:
	if (save_data == null):
		return
	save_data.digging_areas_list.set_digging_area_state(area_id, already_dug)
	ResourceSaver.save(save_data, SAVE_DATA_PATH)

func save_note_state(note_id: int, already_get: bool) -> void:
	if(save_data == null):
		return 
	save_data.note_states_list.set_note_state(note_id, already_get)	
	ResourceSaver.save(save_data, SAVE_DATA_PATH)

func load_save() -> void: 
	if ResourceLoader.exists(SAVE_DATA_PATH):
		var data = ResourceLoader.load(SAVE_DATA_PATH)
		if data is SaveData: 
			save_data = data		

func load_digging_areas_data() -> Array[DiggingArea]:
	if (save_data == null):
		load_save()
	if (save_data != null):
		return save_data.digging_areas_list.digging_areas
	return []

func load_player_inventory_data() -> PlayerInventory:
	if (save_data == null):
		load_save()
	if (save_data != null):
		return save_data.player_inventory
	return null

func load_note_states_data() -> Array[NoteState]:
	if (save_data == null):
		load_save()
	if (save_data != null):
		return save_data.note_states_list.note_states
	return []
