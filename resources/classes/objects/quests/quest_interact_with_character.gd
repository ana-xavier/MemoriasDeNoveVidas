extends QuestCharacter
class_name QuestInteractWithCharacter

func check_and_complete_quest() -> void:
	super()

func on_going_quest_tostring() -> String:
	var result: String = ""
	result += name + ":\n"
	
	if status == Quest.Status.COMPLETE:
		result += set_checkbox_checked(objective_display) + "\n"

	result += set_checkbox(objective_display) + "\n"

	return result
