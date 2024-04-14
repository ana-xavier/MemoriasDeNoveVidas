extends Node2D

@onready var timer: Timer = $Timer

enum HoldMessage {
	SUCCEED,
	STOPPED
}

enum HoldType {
	DIGGING
}

const default_wait_time: float = 2
var is_holding: bool = false
var curr_interactionType: HoldType

signal finished_hold

func start_holding(_wait_time: float, interaction_type: HoldType):
	if not timer.is_stopped():
		return
	timer.wait_time = _wait_time
	curr_interactionType = interaction_type
	timer.start()
	is_holding = true

func stop_holding(hold_message: HoldMessage):
	finished_hold.emit(hold_message)
	is_holding = false
	timer.wait_time = default_wait_time

func _unhandled_key_input(event):
	if is_holding and event.is_action_released("interact"):
		stop_holding(HoldMessage.STOPPED)
		timer.stop()

func _on_timer_timeout():
	stop_holding(HoldMessage.SUCCEED)
	
