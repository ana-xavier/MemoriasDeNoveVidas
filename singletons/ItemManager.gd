extends Node

var data: ItemsList = preload("res://resources/data/items_list.tres")

func get_quest_item_by_id(item_id: String) -> QuestItem:
	return data.get_quest_item_by_id(item_id)
