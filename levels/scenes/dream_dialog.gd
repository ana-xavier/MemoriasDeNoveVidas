extends Cutscene

const dialogue_cutscene = [
	{"character": "dad", "line": "Misty, minha querida! É tão bom te ver."},
	{"character": "mom", "line": "Sentimos tanto a sua falta, querida. Lembra-se dessa viagem? Foi um dos nossos momentos mais felizes juntos."},
	{"character": "dad", "line": "Encontramos você próximo àquela estátua perto da cidade. Desde então, você se tornou muito importante em nossas vidas."},
	{"character": "mom", "line": "Todos os momentos que passamos juntos foram preciosos. Você trouxe tanta alegria para nós."},
	{"character": "dad", "line": "Misty, nós sentimos sua falta desde que você se foi... Se passarão anos desde então."},
	{"character": "mom", "line": "Foi tão difícil, mas sabíamos que um dia estaríamos juntos novamente."},
	{"character": "dad", "line": "Tudo vai ficar bem, querida. Não tenha medo."},
	{"character": "mom", "line": "Logo estaremos juntos novamente, e nunca mais teremos que nos separar."},
	{"character": "dad", "line": "Veja, há uma luz ali adiante. Siga-a, Misty."},
	{"character": "mom", "line": "Ela te levará a um lugar de paz. Estaremos sempre com você, não importa onde esteja."},
	{"character": "misty", "line": "Eu amo vocês, mamãe e papai. Obrigada por tudo."},
	{"character": "mom", "line": "Tudo vai ficar bem... Logo estaremos juntos novamente."}
]

@export var destination_camera: Camera2D = null
@export var destination_camera2: Camera2D = null

func prerequisites() -> bool:
	return true
	
func run() -> void:
	var player = cutscene_trigger.get_player_node() as MainCharacter
	var player_camera = cutscene_trigger.get_player_camera()
	var misty_character = cutscene_trigger.get_character_node("Misty") as CatFollowCharacter
	var mom_character = cutscene_trigger.get_character_node("MistyMom") as HumanSideCharacter
	var dad_character = cutscene_trigger.get_character_node("MistyDad") as HumanSideCharacter
	
	CutsceneManager.start_cutscene(true)
	
	CameraTransition.transition_camera2D(player_camera, destination_camera)
	
	misty_character.get_node("Sprite").frame = player.get_node("Sprite").frame
	var player_pos = player.global_position
	player.global_position = Vector2.ZERO
	misty_character.global_position = player_pos
	
	
	cutscene_trigger.set_character_target_path(misty_character, Vector2(248, 40))
	await misty_character.path_finder_component.arrived_at_target	
	misty_character.fsm.force_change_state("idle_waiting_state")
	misty_character.global_position = Vector2.ZERO
	player.global_position = Vector2(248, 40)
	await get_tree().create_timer(0.1).timeout
	player.get_node("Sprite").frame = 242
	
	misty_character.global_position = Vector2.ZERO
	
	mom_character.play_idle_animation(BaseHumanCharacter.Idle.DOWN)
	await get_tree().create_timer(0.2).timeout
	dad_character.play_idle_animation(BaseHumanCharacter.Idle.DOWN)
	await get_tree().create_timer(0.4).timeout
	
	# Dialog
	for dialog in dialogue_cutscene:
		var character = dialog["character"]
		var line = dialog["line"]
		var character_node
		
		match character:
			"dad":
				character_node = dad_character
			"mom":
				character_node = mom_character
			"misty":
				character_node = player
		
		var lines: Array[String]	
		lines.append(line)
		await cutscene_trigger.start_and_wait_dialog(character_node, lines)
		await get_tree().create_timer(0.3).timeout
		
	CameraTransition.transition_camera2D(destination_camera, destination_camera2)
	await CameraTransition.transitioning_complete
	await get_tree().create_timer(2.0).timeout
	CameraTransition.transition_camera2D(destination_camera2, player_camera, 2.0)
	await CameraTransition.transitioning_complete
	
	CutsceneManager.end_cutscene()
