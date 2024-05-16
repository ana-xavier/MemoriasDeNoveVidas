extends Resource
class_name SaveData

const SAVE_DATA_PATH: String = "user://save_data"

@export var player_inventory: PlayerInventory = PlayerInventory.new()
@export var interactive_objects_dict: InteractiveObjectsDict = InteractiveObjectsDict.new()
@export var dialog_ready_list: DialogReadyList = DialogReadyList.new()
@export var quest_list: QuestList = QuestList.new()

func write_save_data() -> void:
	ResourceSaver.save(self, get_save_path())

static func save_exists() -> bool:
	return ResourceLoader.exists(get_save_path())

static func load_save_data() -> Resource: 
	var save_data_path: String = get_save_path()
	if ResourceLoader.exists(save_data_path):
		return ResourceLoader.load(save_data_path)
	return null
	
static func get_save_path() -> String:
	var extension := ".tres" if OS.is_debug_build() else ".res"
	return SAVE_DATA_PATH + extension
