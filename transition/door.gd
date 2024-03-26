extends Area2D

class_name Door

var player_ref: MainCharacter = null

@export var destination_level_tag: String
@export var destination_door_tag: String
@export var spawn_direction = "up"

@export_category("Objects")
@export var animation: AnimationPlayer = null

@onready var spawn = $Spawn

func _on_body_entered(body):
	if body is MainCharacter:
		if(destination_level_tag == "level_1"):
			NavigationManager.go_to_level(destination_level_tag, destination_door_tag)
		else:
			player_ref = body
			animation.play("door_open")


func _on_animation_finished(anim_name):
	if anim_name == "door_open":
		NavigationManager.go_to_level(destination_level_tag, destination_door_tag)
	
