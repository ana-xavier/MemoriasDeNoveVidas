extends ActionScript

const lines: Array[String] = ["Onde estão meus pais? Eles nunca ficaram fora por tanto tempo.",
							 "Preciso encontrá-los..."
							]

func run(trigger_node: Node2D, body: CharacterBody2D) -> bool:
	await DialogManager.start_dialog(body.global_position, lines, GlobalData.main_character_name)
	return true
