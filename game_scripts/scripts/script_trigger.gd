extends Area2D

@export var game_script: GDScript = null

var id: String = ""
var player_position: Vector2

func _ready():
	id = game_script.get_path().get_file().get_basename()
	if InteractiveObjectsData.is_object_already_interacted(id):
		queue_free()

func _on_body_entered(body):
	if body is MainCharacter:
		player_position = body.global_position
		if game_script:
			run_script()

func run_script() -> void:
	var instance = game_script.new()
	await instance.run(player_position)
	InteractiveObjectsData.set_object_already_interacted(id)
	queue_free()
	

	
