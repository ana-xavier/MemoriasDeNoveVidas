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

func has_item(id: String, amount: int) -> bool:
	if items.has(id):
		var current_amount: int = items.get(id)
		if amount <= current_amount:
			return true
		else:
			return false
	return false

func get_quantity(id: String) -> int:
	if items.has(id):
		return items.get(id)
	return 0

func get_all() -> Dictionary:
	return items
