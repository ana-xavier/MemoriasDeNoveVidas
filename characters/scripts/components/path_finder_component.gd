@icon("res://gui/icons/editor/component_icon.png")
extends Node2D
class_name PathFinderComponent

@export var character: CharacterBody2D
@export var navigation_agent: NavigationAgent2D
@export var move_speed: float = 20.0

signal arrived_at_target

var is_following_path: bool = false
var current_target: Vector2

var direction: Vector2

func find_and_follow_path(target: Vector2):
	navigation_agent.target_position = target
	is_following_path = true

func _physics_process(_delta: float):
	if !is_following_path:
		return

	if navigation_agent.is_navigation_finished():
		is_following_path = false
		arrived_at_target.emit()
	
	direction = navigation_agent.get_next_path_position() - character.global_position
	character.velocity = direction.normalized() * move_speed
	character.move_and_slide()
