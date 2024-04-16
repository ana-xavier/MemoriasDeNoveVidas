extends Node

var data: PlayerInventory = preload("res://data/player_inventory.tres")

func add_item(item: QuestItem) -> void:
	data.add_item(item)

func remove_item(id: String) -> void:
	data.remove_item(id)

func has_item(id: String) -> bool:
	return data.has_item(id)
