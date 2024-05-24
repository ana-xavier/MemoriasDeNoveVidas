extends Area2D

@export var action_script: GDScript = null

var id: String = ""
var player: CharacterBody2D 

func _ready():
	if action_script:
		id = action_script.get_path().get_file().get_basename()
	else:
		push_error("Add a ActionScript to execute")
	if InteractiveObjectsData.is_object_already_interacted(id):
		queue_free()

func _on_body_entered(body):
	if body is MainCharacter && action_script:
		player = body
		run_script()

func run_script() -> void:
	var executed: bool = await action_script.new().run(self, player)
	if executed:
		InteractiveObjectsData.set_object_already_interacted(id)
		queue_free()
	

	
