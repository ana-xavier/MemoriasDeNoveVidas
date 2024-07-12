extends QuestInteractWithCharacter
class_name QuestFinalCatsTalk

const quest_id: String = "misty_and_jujubinha_talk"

func check_and_complete_quest() -> void:
	if QuestManager.is_quest_active(quest_id):
		super()
		await SignalBus.dialog_boxes_finished
		SignalBus.start_cutscene_by_id.emit("misty_sleeps")
