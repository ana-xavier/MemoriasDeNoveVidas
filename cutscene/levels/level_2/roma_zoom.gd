extends Cutscene

@export var destination_camera: Camera2D = null

func prerequisites() -> bool:
	return true
	
func run() -> void:
	var player_camera: Camera2D = cutscene_trigger.get_player_camera()
	
	CutsceneManager.start_cutscene()
	
	CameraTransition.transition_camera2D(player_camera, destination_camera, 2.0)
	await CameraTransition.transitioning_complete
	
	await get_tree().create_timer(2.0).timeout
	
	CameraTransition.transition_camera2D(destination_camera, player_camera)
	await CameraTransition.transitioning_complete	
	
	CutsceneManager.end_cutscene()
