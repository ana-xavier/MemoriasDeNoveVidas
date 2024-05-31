extends Door

@onready var interaction_area: InteractionArea = $InteractionArea

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	go_to_level()

func _on_body_entered(body):
	if body is MainCharacter:
		player_ref = body

