extends ActionScript

const lines: Array[String] = ["Que b-barulho foi esse???"]

func run(trigger_node: Node2D, body: CharacterBody2D) -> bool:
	var character = trigger_node.get_parent().get_parent().get_node("YSort/Jujubinha") as CatFollowCharacter
	if character:
		character.animation.play("surprised")
		await character.animation.animation_finished
		await DialogManager.start_dialog(character.global_position, lines, character.character_name)
		character.animation.play("shaking")
	return true
