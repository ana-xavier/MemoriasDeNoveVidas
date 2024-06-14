extends Node

var data: PlayerInventory = null

signal item_added(item_name: String, item_sprite: Texture, amount: int)

func add_item(id: String, amount: int = 1) -> void:
	data.add_item(id, amount)
	var item: Item = ItemsData.get_item_data_by_id(id)
	if item:
		item_added.emit(item.name, item.sprite, amount)

func remove_item(id: String, amount: int = 1) -> void:
	data.remove_item(id, amount)

func has_item(id: String, amount: int = 1) -> bool:
	return data.has_item(id, amount)
	
func get_quantity(id: String) -> int:
	return data.get_quantity(id)
