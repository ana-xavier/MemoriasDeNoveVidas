extends Cutscene

const dialogue_cutscene = [
	{"character": "misty", "line": "Jujubinha? O que você está fazendo aqui?"},
	{"character": "jujubinha", "line": "Ofegante* Eu decidi vir até a cidade, Misty. Não podia deixar você enfrentar tudo isso sozinha."},
	{"character": "misty", "line": "Sorrindo* Estou tão orgulhosa de você, Jujubinha! Isso é muito corajoso da sua parte."},
	{"character": "jujubinha", "line": "Bem, eu ainda estou um pouco assustado, mas não posso mais ficar parado."},
	{"character": "jujubinha", "line": "Eu preciso encontrar informações sobre meus pais também. E... eu queria te ajudar."},
	{"character": "misty", "line": "Isso é ótimo! Vamos trabalhar juntos para descobrir mais. Tenho certeza de que encontraremos alguma coisa."},
	{"character": "jujubinha", "line": "Combinado! Mas antes, acho que vou dar uma volta pela cidade. Quem sabe eu descubra alguma coisa útil?"},
	{"character": "misty", "line": "Boa ideia. Nos encontramos mais tarde na praça então. Tome cuidado, Jujubinha."},
	{"character": "jujubinha", "line": "Pode deixar, Misty. Até logo!"}
]


@export var destination_camera: Camera2D = null

func prerequisites() -> bool:
	return true
	
func run() -> void:
	var player_camera: Camera2D = cutscene_trigger.get_player_camera()
	var player = cutscene_trigger.get_player_node() as MainCharacter
	var misty_character = cutscene_trigger.get_character_node("Misty") as CatFollowCharacter
	var jujubinha_character = cutscene_trigger.get_character_node("JujubinhaFollow") as CatFollowCharacter
	var base_misty_pos: Vector2 = misty_character.global_position
	var base_jujubinha_pos: Vector2 = jujubinha_character.global_position
	
	CutsceneManager.start_cutscene()
	
	CameraTransition.transition_camera2D(player_camera, destination_camera, 5.0)
	
	misty_character.get_node("Sprite").frame = player.get_node("Sprite").frame
	var player_pos = player.global_position
	player.global_position = base_misty_pos
	misty_character.global_position = player_pos
	
	
	cutscene_trigger.set_character_target_path(misty_character, Vector2(-50, 110))
	await misty_character.path_finder_component.arrived_at_target	
	misty_character.fsm.force_change_state("idle_waiting_state")
	
	misty_character.global_position = base_misty_pos
	player.global_position = Vector2(-50, 110)
	misty_character.global_position = Vector2.ZERO
	player.get_node("Sprite").frame = 78
	
	jujubinha_character.global_position = Vector2(-176, 82)
	cutscene_trigger.set_character_target_path(jujubinha_character, Vector2(-80, 110))
	await jujubinha_character.path_finder_component.arrived_at_target	
	jujubinha_character.fsm.force_change_state("idle_waiting_state")
	await get_tree().create_timer(0.5).timeout
	jujubinha_character.get_node("Sprite").frame = 366
	
	await get_tree().create_timer(0.5).timeout	
	# Dialog
	for dialog in dialogue_cutscene:
		var character = dialog["character"]
		var line = dialog["line"]
		var character_node
		
		match character:
			"jujubinha":
				character_node = jujubinha_character
			"misty":
				character_node = player
		
		var lines: Array[String]	
		lines.append(line)
		await cutscene_trigger.start_and_wait_dialog(character_node, lines)
		await get_tree().create_timer(0.3).timeout
	
	cutscene_trigger.set_character_target_path(jujubinha_character, Vector2(116, 92))
	await jujubinha_character.path_finder_component.arrived_at_target	
	jujubinha_character.fsm.force_change_state("idle_waiting_state")
	jujubinha_character.global_position = base_jujubinha_pos
	
	#await get_tree().create_timer(5.0).timeout
	CameraTransition.transition_camera2D(destination_camera, player_camera)
	await CameraTransition.transitioning_complete
	
	CutsceneManager.end_cutscene()
