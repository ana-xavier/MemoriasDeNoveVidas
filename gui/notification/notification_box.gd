extends MarginContainer

@onready var label = $MarginContainer/Label
@onready var timer = $Timer
@onready var icon = $NinePatchRect/Control/Sprite2D

@export var succeed_icon: Texture = null
@export var new_objective_icon: Texture = null

var visibility_time = 4 

func _ready():
	visible = false

func show_notification_new_objective():
	label.text = "Novo Objetivo!"
	visible = true
	icon.texture = new_objective_icon
	timer.start(visibility_time)
		
func show_notification_objective_succeed():
	label.text = "Objetivo Concluido!"
	visible = true
	icon.texture = succeed_icon
	timer.start(visibility_time)
		
func close_notification_box():
	visible = false
	
		
func _on_timer_timeout():
	close_notification_box()
