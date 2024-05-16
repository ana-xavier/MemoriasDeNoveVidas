extends CanvasLayer

signal on_transition_finished

@onready var animation = $AnimationPlayer
@onready var color_rect = $ColorRect

func _ready():
	color_rect.visible = false
	animation.animation_finished.connect(_on_animation_finished)
	
func _on_animation_finished(name):
	if(name == "fade"):
		animation.play("without_fade")
	elif(name == "without_fade"):
		color_rect.visible = false

func transition():
	color_rect.visible = true
	animation.play("fade")
