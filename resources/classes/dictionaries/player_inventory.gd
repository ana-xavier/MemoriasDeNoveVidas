extends Resource
class_name PlayerInventory

@export var items: Dictionary = {}

func add_item(id: String, amount: int = 1) -> void:
	if items.has(id):
		items[id] += amount
	else:
		items[id] = amount

func remove_item(id: String, amount: int = 1) -> void:
	if !items.has(id):
		return
		
	items[id] -= amount
	if items[id] <= 0:
		items.erase(id)

func has_item(id: String) -> bool:
	return items.has(id)
