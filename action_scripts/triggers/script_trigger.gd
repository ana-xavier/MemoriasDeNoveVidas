extends Area2D
class_name ScriptTrigger

enum TriggerType {
	BODY_ENTERED,
	BODY_EXITED,
	BOTH
}

@export var action_script: GDScript = null
@export var trigger_type: TriggerType = TriggerType.BODY_ENTERED

var id: String = ""
var player: CharacterBody2D 

func _ready():
	if action_script:
		id = action_script.get_path().get_file().get_basename()
	else:
		push_error("Add an ActionScript to execute")
	if InteractiveObjectsData.is_object_already_interacted(id):
		queue_free()

func _on_body_entered(body):
	if (!trigger_type == TriggerType.BODY_ENTERED && !trigger_type == TriggerType.BOTH):
		return
	
	if body is MainCharacter && action_script:
		player = body
		run_script()

func _on_body_exited(body):
	if (!trigger_type == TriggerType.BODY_EXITED && !trigger_type == TriggerType.BOTH):
		return
	
	if body is MainCharacter && action_script:
		player = body
		run_script()

func run_script() -> void:
	var executed: bool = await action_script.new().run(self, player)
	if executed:
		InteractiveObjectsData.set_object_already_interacted(id)
		queue_free()

