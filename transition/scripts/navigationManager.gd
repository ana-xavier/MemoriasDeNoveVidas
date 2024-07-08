extends Node

const scene_level1 = preload("res://levels/scenes/level_1.tscn")
const scene_house = preload("res://levels/scenes/house.tscn")
const scene_house_3_firstfloor = preload("res://levels/scenes/house_3_firstfloor.tscn")
const scene_house_3_secondfloor = preload("res://levels/scenes/house_3_secondfloor.tscn")
const scene_forest = preload("res://levels/scenes/forest.tscn")
const scene_forest_house = preload("res://levels/scenes/forest_house.tscn")

const scene_level1_transition = preload("res://levels/scenes/level_1_transition.tscn")
const scene_level2 = preload("res://levels/scenes/level_2.tscn")

signal on_trigger_player_spawn

var spawn_door_tag

func match_level_tag(level_tag):
	match level_tag:
		"level_1":
			return scene_level1
		"house":
			return scene_house
		"house_3_firstfloor":
			return scene_house_3_firstfloor	
		"house_3_secondfloor":
			return scene_house_3_secondfloor
		"forest":
			return scene_forest
		"forest_house":
			return scene_forest_house	
		"level_1_transition":
			return scene_level1_transition
		"level_2":
			return scene_level2
	return null

func go_to_level(level_tag, destination_tag):
	var scene_to_load = match_level_tag(level_tag)
	
	if scene_to_load != null:
		Transition.transition()
		await Transition.on_transition_finished
		
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed(scene_to_load)


func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)
