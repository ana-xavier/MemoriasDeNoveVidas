extends Area2D

@export var text: String = ""

func _on_body_entered(body):
	if body is MainCharacter:
		SignalBus.open_content_container.emit(text)
		await SignalBus.closed_content_container
