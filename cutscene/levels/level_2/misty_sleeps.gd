extends Cutscene

const scene_to_load = preload("res://levels/scenes/dream_level.tscn")
@export var white_screen: ColorRect = null
@export var destination_camera: Camera2D = null

func prerequisites() -> bool:
	return true
	
func run() -> void:
	var player = cutscene_trigger.get_player_node() as MainCharacter
	var player_camera = cutscene_trigger.get_player_camera()
	var misty_character = cutscene_trigger.get_character_node("Misty") as CatFollowCharacter
	var base_misty_pos: Vector2 = misty_character.global_position
	
	
	CutsceneManager.start_cutscene()
	
	CameraTransition.transition_camera2D(player_camera, destination_camera)
	
	misty_character.get_node("Sprite").frame = player.get_node("Sprite").frame
	var player_pos = player.global_position
	player.global_position = base_misty_pos
	misty_character.global_position = player_pos
	
	cutscene_trigger.set_character_target_path(misty_character, Vector2(400, 270))
	await misty_character.path_finder_component.arrived_at_target	
	misty_character.fsm.force_change_state("idle_waiting_state")
	
	misty_character.global_position = base_misty_pos
	player.global_position = Vector2(400, 270)
	misty_character.global_position = Vector2.ZERO
	player.get_node("Sprite").frame = 366
	
	await get_tree().create_timer(1.0).timeout
	player.animation_player.play("laying_down")
	
	await get_tree().create_timer(3.0).timeout
	await create_tween().tween_property(
		white_screen, "color:a", 1, 1.5
	).finished
	await get_tree().create_timer(2.0).timeout
	CutsceneManager.end_cutscene()

	get_tree().change_scene_to_packed(scene_to_load)
