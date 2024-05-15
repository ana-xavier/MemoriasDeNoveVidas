extends MarginContainer

@onready var title = $MarginContainer/Title
@onready var timer = $Timer
@onready var icon = $NinePatchRect/Icon

@export var succeed_icon: Texture = null
@export var new_objective_icon: Texture = null

const anim_duration: float = 0.3
const visibility_time = 4 
var final_scale: Vector2 = Vector2.ZERO

func _ready():
	visible = false
	QuestManager.quest_active.connect(self.show_notification_new_quest)
	QuestManager.quest_complete.connect(self.show_notification_quest_complete)
	

func show_notification_new_quest():
	title.text = "Novo Objetivo!"
	icon.texture = new_objective_icon
	visible = true
	_animate()
	timer.start(visibility_time)
	
func show_notification_quest_complete():
	title.text = "Objetivo Concluido!"
	icon.texture = succeed_icon
	visible = true
	_animate()
	timer.start(visibility_time)

func _animate() -> void:
	final_scale = scale
	scale = Vector2.ZERO
	var tween = get_tree().create_tween()
	tween.tween_property(
		self, "scale", final_scale, anim_duration
	).set_trans(Tween.TRANS_BACK)

func close_notification_box():
	visible = false
	
func _on_timer_timeout():
	close_notification_box()
