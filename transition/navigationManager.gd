extends Node

const scene_level1 = preload("res://levels/scenes/level_1.tscn")
const scene_house = preload("res://levels/scenes/house.tscn")
const scene_house_3_firstfloor = preload("res://levels/scenes/house_3_firstfloor.tscn")
const scene_house_3_secondfloor = preload("res://levels/scenes/house_3_secondfloor.tscn")

signal on_trigger_player_spawn

var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	
	match level_tag:
		"level_1":
			scene_to_load = scene_level1
		"house":
			scene_to_load = scene_house
		"house_3_firstfloor":
			scene_to_load = scene_house_3_firstfloor	
		"house_3_secondfloor":
			scene_to_load = scene_house_3_secondfloor
			
	if scene_to_load != null:
		Transition.transition()
		await Transition.on_transition_finished
		
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed(scene_to_load)

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)
