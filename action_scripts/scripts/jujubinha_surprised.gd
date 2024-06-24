extends ActionScript

const lines: Array[String] = ["Que b-barulho foi esse???"]

func run(trigger_node: Node2D, _body: CharacterBody2D) -> bool:
	var character = trigger_node.get_parent().get_parent().get_node("YSort/Jujubinha") as CatFollowCharacter
	if character:
		var animation = character.get_node("Animation") as AnimationPlayer
		animation.play("surprised")
		await animation.animation_finished
		await DialogManager.start_dialog(character.global_position, lines, character.character_name, false, false, "[color=#00688B]")
		animation.play("shaking")
	return true
