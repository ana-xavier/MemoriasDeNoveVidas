extends Node

var data: InteractiveObjectsDict = null

func is_object_already_interacted(object_id: String) -> bool:
	return data.is_object_already_interacted(object_id)
	
func set_object_already_interacted(object_id: String) -> void:
	data.set_object_already_interacted(object_id)

func get_value_in_object(object_id: String, var_name: String) -> bool:
	return data.get_value_in_object(object_id, var_name)
	
func set_value_in_object(object_id: String, var_name: String, value: bool) -> void:
	data.set_value_in_object(object_id, var_name, value)
