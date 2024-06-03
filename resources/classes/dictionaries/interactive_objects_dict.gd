extends Resource
class_name  InteractiveObjectsDict

@export var objects_states: Dictionary = {}

func is_object_already_interacted(object_id: String) -> bool:
	if (objects_states.has(object_id)):
		return objects_states.get(object_id).get("already_interacted")
	return false
	
func set_object_already_interacted(object_id: String) -> void:
	objects_states[object_id] = {"already_interacted": true}

func get_value_in_object(object_id: String, var_name: String) -> bool:
	if (objects_states.has(object_id)):
		var object = objects_states.get(object_id)
		if object.has(var_name):
			return object.get(var_name)
	return false
	
func set_value_in_object(object_id: String, var_name: String, value: bool) -> void:
	objects_states[object_id] = {var_name: value}
