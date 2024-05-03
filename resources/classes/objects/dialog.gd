extends Resource
class_name Dialog

@export var id: String = ""
@export var has_prerequisite: bool = false
@export var prerequisite_quest_id: String = ""
@export var release_a_quest: bool = false
@export var quest_id: String = ""
@export var dialog: Array[DialogBox] = []
