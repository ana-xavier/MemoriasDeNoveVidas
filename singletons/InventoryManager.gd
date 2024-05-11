extends Node

var data: PlayerInventory = preload("res://resources/data/player_inventory.tres")

signal item_added(item_name: String, item_sprite: Texture)

func _ready():
	var player_inventory: PlayerInventory = DataManager.load_player_inventory_data()
	if (player_inventory != null):
		data = player_inventory

func add_item(item: QuestItem) -> void:
	data.add_item(item)
	item_added.emit(item.name, item.sprite)
	DataManager.save_player_inventory(data)

func remove_item(id: String) -> void:
	data.remove_item(id)
	DataManager.save_player_inventory(data)

func has_item(id: String) -> bool:
	return data.has_item(id)
