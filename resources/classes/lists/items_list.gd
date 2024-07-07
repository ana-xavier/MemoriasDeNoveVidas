extends Resource
class_name ItemsList

@export var items: Array[Item] = []

func get_item_data_by_id(item_id: String) -> Item:
	for item in items:
		if item.id == item_id:
			return item
	return null
	
func get_all_secret_items() -> Array[Item]:
	var secret_items: Array[Item] = []
	for item in items:
		if item.category == Item.Category.SECRET:
			secret_items.append(item)
	return secret_items
