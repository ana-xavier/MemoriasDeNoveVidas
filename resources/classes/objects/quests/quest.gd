extends Resource
class_name Quest

const checkbox_icon: String = "res://gui/icons/checkbox.png"
const checkbox_checked_icon: String = "res://gui/icons/checkbox_checked.png"

enum Status {
	INACTIVE,
	ACTIVE,
	COMPLETE
}

@export var id: String = ""
@export var name: String = ""
@export var description: String = ""
@export var objective_display: String
@export var status: Status = Status.INACTIVE
@export var has_prerequisite: bool = false
@export var prerequisite_quest_id: String = ""
	
func check_and_complete_quest() -> void:
	status = Quest.Status.COMPLETE
	QuestManager.on_complete_quest()

func on_going_quest_tostring() -> String:
	return ""

func set_checkbox(objective: String) -> String:
	return "[img=5x5]" + checkbox_icon + "[/img] [color=#585858]" + objective + "[/color]"
	
func set_checkbox_checked(objective: String) -> String:
	return "[img=5x5]" + checkbox_checked_icon + "[/img] [color=#585858]" + objective + "[/color]"

