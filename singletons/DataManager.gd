extends Node

const SAVE_DATA_PATH: String = "res://resources/save/save_data.tres"
const DIGGING_DATA_PATH: String = "res://resources/data/digging_areas_list.tres"

var save_data: SaveData = null

func create_new_save() -> void:
	save_data = SaveData.new()
	save_data.player_inventory = PlayerInventory.new()
	
	var digging_data: DiggingAreasList = load(DIGGING_DATA_PATH)
	save_data.digging_areas = digging_data["digging_areas"]
	# ...
	ResourceSaver.save(save_data, SAVE_DATA_PATH)

func save_player_inventory(inventory: PlayerInventory) -> void:
	if (save_data == null):
		return
	save_data.player_inventory = inventory
	ResourceSaver.save(save_data, SAVE_DATA_PATH)

func save_digging_areas_data() -> void:
	if (save_data == null):
		return
	
	var data: Array[DiggingArea] = []
	var digging_areas_instances = get_tree().get_first_node_in_group("DiggingAreasInstances")
	if (digging_areas_instances != null):
		for child in digging_areas_instances.get_children():
			if child is DiggingAreaNode:
				var digging_area = DiggingArea.new()
				digging_area.already_dug = child.already_dug
				digging_area.can_give_item = child.can_give_item
				digging_area.quest_item_id = child.quest_item_id
				digging_area._position = child.position
				
				data.append(digging_area)
				
		save_data.digging_areas = data
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
		return save_data.digging_areas
	return []

func load_player_inventory_data() -> PlayerInventory:
	if (save_data == null):
		load_save()
	if (save_data != null):
		return save_data.player_inventory
	return null
