extends Node

var data: InteractiveObjectsDict = preload("res://resources/data/interactive_objects_dict.tres")

func _ready():
	var interactive_objects_dict: InteractiveObjectsDict = DataManager.load_interactive_objects_states()
	if (interactive_objects_dict != null):
		data = interactive_objects_dict

func is_object_already_interacted(object_id: String) -> bool:
	return data.is_object_already_interacted(object_id)
	
func set_object_already_interacted(object_id: String) -> void:
	data.set_object_already_interacted(object_id)
	DataManager.save_interactive_objects_states(data)
