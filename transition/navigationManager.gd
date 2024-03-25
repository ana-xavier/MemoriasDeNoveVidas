extends Node

const scene_level1 = preload("res://levels/scenes/level_1.tscn")
const scene_house = preload("res://levels/scenes/house.tscn")

signal on_trigger_player_spawn

var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	print("entrou no navigation")
	print(level_tag)
	print(destination_tag)
	var scene_to_load
	
	match level_tag:
		"level_1":
			scene_to_load = scene_level1
		"house":
			scene_to_load = scene_house
			
	if scene_to_load != null:
		print("scene to load ok")
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed(scene_to_load)

func trigger_player_spawn(position: Vector2, direction: String):
	print("trigger do personagem")
	on_trigger_player_spawn.emit(position, direction)
