extends Node

@onready var objective_notification = get_tree().get_first_node_in_group("NotificationBox")
const RESOURCE_PATH = "res://resources/data/quest_list.tres"
var data: QuestList = null

func _ready():
	var quest_list: QuestList = DataManager.load_quests_status()
	if (quest_list != null):
		data = quest_list
	else:
		load_resource()

func load_resource() -> void: 
	if ResourceLoader.exists(RESOURCE_PATH):
		var resource = ResourceLoader.load(RESOURCE_PATH) as QuestList
		data = resource

func save_quests_status() -> void:
	DataManager.save_quests_status(data.quests)

func get_quest_by_id(quest_id: String) -> Quest:
	return data.get_quest_by_id(quest_id)

func get_quest_by_character_id(character_id: String) -> QuestDeliverItem:
	return data.get_quest_by_character_id(character_id)
	
func set_quest_active(quest_id: String) -> void:
	data.set_quest_active(quest_id)
	DataManager.save_quests_status(data.quests)
	on_active_quest()
	
# TODO - Remover futuramente esta função
#func set_quest_complete(quest_id: String) -> void:
	#data.set_quest_complete(quest_id)
	#DataManager.save_quests_status(data.quests)
	#on_complete_quest()

func is_quest_complete(quest_id: String) -> bool:
	return data.is_quest_complete(quest_id)

func on_active_quest():
	if objective_notification != null:
		objective_notification.show_notification_new_objective()

func on_complete_quest():
	if objective_notification != null:
		objective_notification.show_notification_objective_succeed()

