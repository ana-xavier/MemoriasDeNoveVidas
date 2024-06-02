extends Quest
class_name QuestGoToLocation

@export var character_id: String = ""
@export var finish_objective_display: String = ""
@export var arrived_at_location: bool = false

func check_and_complete_quest() -> void:
	if arrived_at_location:
		super()

func on_going_quest_tostring() -> String:
	var result: String = ""
	result += name + ":\n"
	
	if arrived_at_location:
		result += set_checkbox_checked(objective_display) + "\n"
	else:
		result += set_checkbox(objective_display) + "\n"
		
	if status == Quest.Status.COMPLETE:
		result += set_checkbox_checked(finish_objective_display) + "\n"
	else:
		result += set_checkbox(finish_objective_display) + "\n"
		
	return result
