extends Area2D
class_name Door

var player_ref: MainCharacter = null

@export var door_id: String = ""
@export var door_locked_message: String = "A porta está bloqueada."
@export var destination_level_tag: String
@export var destination_door_tag: String
@export var spawn_direction = "up"

@export_category("Objects")
@export var animation: AnimationPlayer = null

@onready var spawn = $Spawn

func _on_body_entered(body):
	if body is MainCharacter:
		player_ref = body
		go_to_level()

func go_to_level():	
	if is_door_locked():
		SignalBus.open_content_container.emit(door_locked_message)
		return
			
	player_ref.is_player_locked = true
	if animation != null:
		animation.play("door_open")
	else:
		NavigationManager.go_to_level(destination_level_tag, destination_door_tag)

func is_door_locked() -> bool:
	return InteractiveObjectsData.get_value_in_object(door_id, "door_locked")
	
func _on_animation_finished(animation_name):
	if animation_name == "door_open":
		NavigationManager.go_to_level(destination_level_tag, destination_door_tag)
	
