extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $Label

const base_text = "[E] para "

var active_areas = []
var can_interact = true
var hide_label: bool = false

func _ready():
	CutsceneManager.cutscene_started.connect(lock_interaction)
	CutsceneManager.cutscene_ended.connect(unlock_interaction)
	
func register_area(area: InteractionArea): 
	active_areas.push_back(area)

func unregister_area(area: InteractionArea):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)
		
func _process(_delta):
	if hide_label:
		label.hide()
		return
		
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		label.text = active_areas[0].action_type + base_text + active_areas[0].action_name
		label.global_position = active_areas[0].global_position
		label.global_position.y -= 30
		label.global_position.y += active_areas[0].label_offset_y
		label.global_position.x -= label.size.x / 2
		label.show()
	else:
		label.hide()
		
		
func _sort_by_distance_to_player(area1, area2):
	if is_instance_valid(player):
		var player_pos: Vector2 = player.global_position
		var area1_to_player	= player_pos.distance_to(area1.global_position)
		var area2_to_player	= player_pos.distance_to(area2.global_position)
		return area1_to_player < area2_to_player
	return Vector2.ZERO
	
	
func _input(event):
	if event.is_action_pressed("interact") && can_interact:
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
			
			await active_areas[0].interact.call()
			
			can_interact = true

func lock_interaction():
	hide_label = true
	can_interact = false
	
func unlock_interaction():
	hide_label = false
	can_interact = true
