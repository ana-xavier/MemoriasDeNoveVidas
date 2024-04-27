extends Node2D

const data_path: String = "res://data/digging_areas_list.tres"

var digging_area_scene = preload("res://interaction/objects/dirt/digging_area.tscn")
var digging_areas: Array[DiggingArea] = []

func instantiate_digging_areas():
	for area in digging_areas:
		if(not area.already_dug):
			var area_instance = digging_area_scene.instantiate()
			area_instance.init(area.already_dug, area.can_give_item, area.quest_item_id, area._position)
			add_child(area_instance)

func load_data() -> Array[DiggingArea]:
	if ResourceLoader.exists(data_path):
		var data = ResourceLoader.load(data_path)
		if data is DiggingAreasList: # Check that the data is valid
			return data.digging_areas
	return []

func _ready():
	var data: Array[DiggingArea] = DataManager.load_digging_areas_data()
	if (not data.is_empty()):
		digging_areas = data
	else:
		digging_areas = load_data()
	
	instantiate_digging_areas()
