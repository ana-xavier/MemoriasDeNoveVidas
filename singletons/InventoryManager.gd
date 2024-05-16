extends Node

var data: PlayerInventory = null

signal item_added(item_name: String, item_sprite: Texture)

func _ready():
	pass

func add_item(item: QuestItem) -> void:
	data.add_item(item)
	item_added.emit(item.name, item.sprite)

func remove_item(id: String) -> void:
	data.remove_item(id)

func has_item(id: String) -> bool:
	return data.has_item(id)
