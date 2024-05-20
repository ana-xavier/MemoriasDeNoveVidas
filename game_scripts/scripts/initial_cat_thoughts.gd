extends GameScript

const lines: Array[String] = ["Onde estão meus pais? Eles nunca ficaram fora por tanto tempo.",
							 "Preciso encontrá-los..."
							]

func run(position: Vector2) -> void:
	DialogManager.start_dialog(position, lines, "Gatinho")
