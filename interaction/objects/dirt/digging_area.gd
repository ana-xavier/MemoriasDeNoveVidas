extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea

var _wait_time: float = 3

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	if Input.is_action_pressed("interact"):
		InteractionHoldManager.start_holding(_wait_time, InteractionHoldManager.HoldType.DIGGING)
	
	var hold_message = await InteractionHoldManager.finished_hold
	
	if hold_message == InteractionHoldManager.HoldMessage.SUCCEED:
		_on_hold_succeed()

func _on_hold_succeed():
	print("adicionou item ao inventário")
	queue_free()	
