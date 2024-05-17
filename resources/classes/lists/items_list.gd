extends Resource
class_name ItemsList

@export var items: Array[Item] = []

func get_item_data_by_id(item_id: String) -> Item:
	for item in items:
		if item.id == item_id:
			return item
	return null
	
