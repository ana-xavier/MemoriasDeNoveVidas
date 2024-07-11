extends CharacterBody2D
class_name BaseHumanCharacter

@onready var sprite: Sprite2D = $Sprite
@onready var animation: AnimationPlayer = $Animation

@export_category("Base Character")
@export var character_id: String = ""
@export var character_name: String = ""
@export var texture: Texture2D = null
@export var idle_animation: Idle = Idle.DOWN

enum Idle {
	DOWN,
	UP, 
	LEFT, 
	RIGHT
}

func _ready() -> void:
	if texture != null:
		sprite.texture = texture
		
	play_idle_animation(idle_animation)

func play_idle_animation(_idle_animation: Idle):
	animation.stop()
	match _idle_animation:
		Idle.DOWN: animation.play("idle_down")
		Idle.UP : animation.play("idle_up")
		Idle.LEFT: animation.play("idle_left")
		Idle.RIGHT: animation.play("idle_right")
