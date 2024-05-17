extends Node2D
class_name DiggingAreaNode

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var dirt_particles: CPUParticles2D = $CPUParticles2D
@onready var particles_timer: Timer = $Timer

@export var id: String = ""
@export var can_give_item: bool = false
@export var item_id: String = ""

var _wait_time: float = 3

func _ready():
	if (InteractiveObjectsData.is_object_already_interacted(id)):
		queue_free()
	interaction_area.interact = Callable(self, "_on_interact")
	dirt_particles.emitting = false

func _on_interact():
	if Input.is_action_pressed("interact"):
		InteractionHoldManager.start_holding(_wait_time, InteractionHoldManager.HoldType.DIGGING)
	
	particles_timer.start()
	
	var hold_message = await InteractionHoldManager.finished_hold
	
	if hold_message == InteractionHoldManager.HoldMessage.SUCCEED:
		_on_hold_succeed()
	
	particles_timer.stop()
	dirt_particles.emitting = false
	
	
func _on_hold_succeed():
	if (can_give_item):
		InventoryManager.add_item(item_id)
		 
	InteractiveObjectsData.set_object_already_interacted(id)
	queue_free()	
	
	
func _on_timer_timeout():
	dirt_particles.emitting = true
