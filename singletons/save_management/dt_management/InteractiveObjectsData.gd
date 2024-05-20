extends Node

var data: InteractiveObjectsDict = null

func is_object_already_interacted(object_id: String) -> bool:
	return data.is_object_already_interacted(object_id)
	
func set_object_already_interacted(object_id: String) -> void:
	data.set_object_already_interacted(object_id)
