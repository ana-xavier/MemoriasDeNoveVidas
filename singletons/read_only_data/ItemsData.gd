extends Node

const data: ItemsList = preload("res://resources/data/items_list.tres")

func get_item_data_by_id(item_id: String) -> Item:
	return data.get_item_data_by_id(item_id)

func get_all_secret_items() -> Array[Item]:
	return data.get_all_secret_items()
