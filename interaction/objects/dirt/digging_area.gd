extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var dirt_particles: CPUParticles2D = $CPUParticles2D
@onready var particles_timer: Timer = $Timer

@export var quest_item_id: String = ""

var _wait_time: float = 3

func _ready():
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
	print("adicionou item ao inventário")
	# TODO
	# Adicionar item ao player inventory
	# TODO - REMOVER LINHAS ABAIXO (para teste apenas)
	#var item: QuestItem = ItemManager.get_quest_item_by_id("rubber_duck")
	#print(item.name) 
	#InventoryManager.add_item(item)
	queue_free()	


func _on_timer_timeout():
	dirt_particles.emitting = true
