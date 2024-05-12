extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite: Sprite2D = $WoodenSign

@export var text: String = ""
@export var to_left: bool = false

func _ready():
	if to_left:
		sprite.flip_h = true
	
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	print("Leu a Placa")
	print("text")
