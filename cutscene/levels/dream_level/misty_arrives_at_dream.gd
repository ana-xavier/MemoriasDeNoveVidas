extends Cutscene

const lines1: Array[String] = ["Onde estou?     ", "...    "]
const lines2: Array[String] = ["Esse lugar... Eu me lembro dele. Foi aqui que fizemos aquela viagem incrível."]
const lines3: Array[String] = ["Mamãe? Papai? Vocês estão aqui???"]

@export var destination_camera: Camera2D = null
@export var white_screen: ColorRect = null
@export var music: AudioStreamPlayer = null

func prerequisites() -> bool:
	return true
	
func run() -> void:
	var player = cutscene_trigger.get_player_node() as MainCharacter
	var player_camera = cutscene_trigger.get_player_camera()
	
	CutsceneManager.start_cutscene(true)
	
	await get_tree().create_timer(1.5).timeout	
	await create_tween().tween_property(
		white_screen, "color:a", 0, 3.0
	).finished
	
	await get_tree().create_timer(1.0).timeout	
	DialogManager.start_dialog(player.global_position, lines1, "", true, true)
	await DialogManager.dialog_finished
	
	await get_tree().create_timer(1.0).timeout
	player.get_node("Sprite").frame = 242
	await get_tree().create_timer(2.0).timeout
	
	DialogManager.start_dialog(player.global_position, lines2, "", true, true)
	await DialogManager.dialog_finished
	
	CameraTransition.transition_camera2D(player_camera, destination_camera, 2.5)
	await CameraTransition.transitioning_complete
	
	music.play()
	CameraTransition.transition_camera2D(destination_camera, player_camera, 2.0)
	await CameraTransition.transitioning_complete
	
	DialogManager.start_dialog(player.global_position, lines3, "", true, true)
	await DialogManager.dialog_finished
	
	CutsceneManager.end_cutscene()
