extends Node

@onready var item_notification = get_tree().get_first_node_in_group("ItemNotificationBox") ;
var data: PlayerInventory = preload("res://resources/data/player_inventory.tres")

func _ready():
	var player_inventory: PlayerInventory = DataManager.load_player_inventory_data()
	if (player_inventory != null):
		data = player_inventory

func add_item(item: QuestItem) -> void:
	data.add_item(item)
	
	if item_notification != null:
		item_notification.show_notification(item.name, item.sprite)
	
	DataManager.save_player_inventory(data)

func remove_item(id: String) -> void:
	data.remove_item(id)
	DataManager.save_player_inventory(data)

func has_item(id: String) -> bool:
	return data.has_item(id)
