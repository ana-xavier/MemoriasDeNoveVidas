extends Control

@onready var data_container = $DataContainer
@onready var new_game_list = $DataContainer/MarginContainer/MarginContainer/NewGameAndLoadTab/NewGameList
@onready var load_game_list = $DataContainer/MarginContainer/MarginContainer/NewGameAndLoadTab/LoadGameList
@onready var conitnue_button = $controls/continue

var speedCloudFront: float = 0.03
var speedCloudBack: float = 0.01

var cloudFrontOne: Node2D
var cloudFrontTwo: Node2D
var cloudBackOne: Node2D
var cloudBackTwo: Node2D

func _on_start_pressed() -> void:
	data_container.open_new_game_tab()
	if new_game_list.is_slots_empty:
		get_tree().change_scene_to_file("res://transition/text_scene/text_scene.tscn")
		SaveManager.create_new_save(1)
		Transition.transition_menu()

func _on_continue_pressed():
	data_container.open_load_game_tab()

func _ready():
	data_container.visible = false
	if load_game_list.has_saved_data:
		conitnue_button.visible = true
	cloudFrontOne = get_node("menu/cloudFrontOne")
	cloudFrontTwo = get_node("menu/cloudFrontTwo")
	
	cloudBackOne = get_node("menu/cloudBackOne")
	cloudBackTwo = get_node("menu/cloudBackTwo")

func _process(delta):
	_move_clouds(delta)

func _move_clouds(delta: float):
	#print(-100 * speedCloudFront * delta)
	#print(delta)
	
	cloudFrontOne.transform = cloudFrontOne.transform.translated(Vector2(-100 * speedCloudFront * delta, 0))
	cloudFrontTwo.transform = cloudFrontTwo.transform.translated(Vector2(-100 * speedCloudFront * delta, 0))
	cloudBackOne.transform = cloudBackOne.transform.translated(Vector2(-100 * speedCloudBack * delta, 0))
	cloudBackTwo.transform = cloudBackTwo.transform.translated(Vector2(-100 * speedCloudBack * delta, 0))

	if cloudFrontOne.position.x < -210:
		cloudFrontOne.position = Vector2(560,87) 
	if cloudFrontTwo.position.x < -210:
		cloudFrontTwo.position = Vector2(560,87)
	if cloudBackTwo.position.x < -210:
		cloudBackTwo.position = Vector2(560,87) 
	if cloudFrontOne.position.x < -210:
		cloudBackTwo.position = Vector2(560,87)
		

#func _on_controls_pressed() -> void:
	#get_tree().change_scene_to_file("res://character/scenes/controls.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
