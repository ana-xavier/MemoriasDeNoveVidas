extends Node

var data: PlayerInventory = null

signal item_added(item_name: String, item_sprite: Texture)

func add_item(id: String) -> void:
	data.add_item(id)
	var item: Item = ItemsData.get_item_data_by_id(id)
	item_added.emit(item.name, item.sprite)

func remove_item(id: String) -> void:
	data.remove_item(id)

func has_item(id: String, quantity: int = 1) -> bool:
	return data.has_item(id, quantity)
	
func get_quantity(id: String) -> int:
	return data.get_quantity(id)
