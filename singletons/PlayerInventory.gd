extends Node

var quest_items = []

func _ready():
	add_item("rubber_duck", "srpotatoe_item_quest", "Patinho de Borracha")

func add_item(id: String, quest_id: String, name: String):
	var item = {
		"id": id,
		"quest_id": quest_id,
		"name": name
	}
	quest_items.append(item)

func remove_item(id: String):
	for i in range(quest_items.size()):
		if quest_items[i]["id"] == id:
			quest_items.remove_at(i)
			return

func has_item(id: String):
	for item in quest_items:
		if item["id"] == id:
			return true
	return false
