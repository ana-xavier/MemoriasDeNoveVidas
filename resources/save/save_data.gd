extends Resource
class_name SaveData

@export var already_saved: bool = false
@export var global_variables: GlobalVariables = GlobalVariables.new()
@export var player_inventory: PlayerInventory = PlayerInventory.new()
@export var interactive_objects_dict: InteractiveObjectsDict = InteractiveObjectsDict.new()
@export var dialog_ready_list: DialogReadyList = DialogReadyList.new()
@export var quest_list: QuestList = QuestList.new()

func write_save_data(slot: int) -> void:
	ResourceSaver.save(self, SaveData.get_save_path(slot))

static func save_exists(slot: int) -> bool:
	return ResourceLoader.exists(SaveData.get_save_path(slot))

static func load_save_data(slot: int) -> Resource:
	var save_data_path: String = SaveData.get_save_path(slot)
	if ResourceLoader.exists(save_data_path):
		return ResourceLoader.load(save_data_path)
	return null

static func get_save_path(slot: int) -> String:
	var extension := ".tres" if OS.is_debug_build() else ".res"
	return "user://save_data_" + str(slot) + extension
