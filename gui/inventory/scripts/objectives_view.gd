extends Control

@onready var objectives_text: RichTextLabel = $ObjectivesContent

func update_displayed_objectives() -> void:
	objectives_text.text = ""
	var quests: Array[Quest] = QuestManager.data.quests
	for quest in quests:
		if quest.status ==  Quest.Status.ACTIVE:
			objectives_text.text += quest.on_going_quest_tostring()


func _on_save_button_mouse_entered():
	pass # Replace with function body.
