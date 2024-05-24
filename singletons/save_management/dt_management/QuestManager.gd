extends Node

const RESOURCE_PATH = "res://resources/data/quest_list.tres"
var data: QuestList = null

signal quest_active()
signal quest_complete()

func _ready():
	pass

func load_quests_resource() -> Array[Quest]: 
	if ResourceLoader.exists(RESOURCE_PATH):
		var resource = ResourceLoader.load(RESOURCE_PATH) as QuestList
		return resource.quests
	return []

func get_quest_by_id(quest_id: String) -> Quest:
	return data.get_quest_by_id(quest_id)

func get_quest_by_character_id(character_id: String) -> QuestDeliverItem:
	return data.get_quest_by_character_id(character_id)
	
func set_quest_active(quest_id: String) -> void:
	data.set_quest_active(quest_id)
	on_active_quest()

func is_quest_inactive(quest_id: String) -> bool:
	return data.is_quest_inactive(quest_id)

func is_quest_complete(quest_id: String) -> bool:
	return data.is_quest_complete(quest_id)

func on_active_quest():
	quest_active.emit()

func on_complete_quest():
	quest_complete.emit()
