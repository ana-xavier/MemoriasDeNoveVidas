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

func has_item(id: String, quantity: int) -> bool:
	if items.has(id):
		var current_quantity: int = items.get(id)
		if quantity <= current_quantity:
			return true
		return false
	return false

func get_quantity(id: String) -> int:
	if items.has(id):
		return items.get(id)
	return 0
