extends CharacterBody2D
class_name BaseCharacter

@onready var sprite: Sprite2D = $Sprite

@export_category("Base Character")
@export var character_id: String = ""
@export var character_name: String = ""
@export var texture: Texture2D = null
@export var frame: int = 50

func _ready() -> void:
	if texture != null:
		sprite.texture = texture
		sprite.frame = frame
