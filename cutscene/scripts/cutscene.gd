extends Node2D
class_name Cutscene

@export var id: String = ""
@export var one_time_only: bool = true
@export var cutscene_trigger: CutsceneTrigger = null

func prerequisites() -> bool:
	return false
	
func run() -> void:
	pass

