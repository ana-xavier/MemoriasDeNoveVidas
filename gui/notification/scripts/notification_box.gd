extends MarginContainer

@onready var title = $MarginContainer/Title
@onready var timer = $Timer
@onready var icon = $NinePatchRect/Icon

@export var succeed_icon: Texture = null
@export var new_objective_icon: Texture = null

var visibility_time = 4 

func _ready():
	visible = false
	QuestManager.quest_active.connect(self.show_notification_new_quest)
	QuestManager.quest_complete.connect(self.show_notification_quest_complete)
	

func show_notification_new_quest():
	title.text = "Novo Objetivo!"
	icon.texture = new_objective_icon
	visible = true
	timer.start(visibility_time)
	
func show_notification_quest_complete():
	title.text = "Objetivo Concluido!"
	icon.texture = succeed_icon
	visible = true
	timer.start(visibility_time)
	
func close_notification_box():
	visible = false
	
func _on_timer_timeout():
	close_notification_box()
