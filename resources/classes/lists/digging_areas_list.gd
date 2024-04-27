extends Resource
class_name DiggingAreasList

@export var digging_areas: Array[DiggingArea] = []

func set_digging_area_state(id: int, already_dug: bool) -> void:
	for area in digging_areas:
		if (area.id == id):
			area.already_dug = already_dug
			return 
