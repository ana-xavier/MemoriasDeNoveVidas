extends Resource
class_name  DiggingAreasDict

@export var digging_areas: Dictionary = {}

func is_area_already_dug(area_id: String) -> bool:
	if(digging_areas.has(area_id)):
		return digging_areas.get(area_id).get("already_dug")
	return false
	
func set_area_already_dug(area_id: String) -> void:
	digging_areas[area_id] = {"already_dug": true}
