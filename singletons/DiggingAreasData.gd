extends Node

var data: DiggingAreasDict = preload("res://resources/data/digging_areas_dict.tres")

func _ready():
	var digging_areas_dict: DiggingAreasDict = DataManager.load_digging_areas_data()
	if (digging_areas_dict != null):
		data = digging_areas_dict

func is_area_already_dug(area_id: String) -> bool:
	return data.is_area_already_dug(area_id)
	
func set_area_already_dug(area_id: String) -> void:
	data.set_area_already_dug(area_id)
	DataManager.save_digging_areas_states(data)
