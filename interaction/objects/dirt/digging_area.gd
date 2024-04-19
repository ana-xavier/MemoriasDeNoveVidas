extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var dirt_particles: CPUParticles2D = $CPUParticles2D
@onready var particles_timer: Timer = $Timer

@export var already_dug: bool = false
@export var can_give_item: bool = false
@export var quest_item_id: String = ""

var _wait_time: float = 3

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	dirt_particles.emitting = false

func init(_already_dug: bool, _can_give_item: bool, _item_id, _position: Vector2):
	already_dug = _already_dug
	can_give_item = _can_give_item
	quest_item_id = _item_id
	position = _position

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
		var item: QuestItem = ItemManager.get_quest_item_by_id(quest_item_id)
		InventoryManager.add_item(item)
		# TODO - Remover prints abaixo
		print("Adicionou item ao inventário:")
		print(item.name)
		 
	already_dug = true
	queue_free()	


func _on_timer_timeout():
	dirt_particles.emitting = true
