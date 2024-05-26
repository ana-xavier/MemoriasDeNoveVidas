extends BaseCharacter
class_name CatSideCharacter

@export_category("Dialog Component")
@export var character_idle_dialog: Dialog = null
@export var character_dialogs: Array[Dialog] = []

@export_category("Quest Component")
@export var char_interact_quest_id: String = ""

@export_category("Movement")
@export var speed: int = 20
@export var max_distance_from_start: float = 35.0

@export_subgroup("States")
@export var player_near_state: State = null

@onready var timer: Timer = $Timer
@onready var dialog_component: DialogComponent = $DialogComponent
@onready var quest_component: QuestComponent = $QuestComponent
@onready var fsm: FiniteStateMachine = $FiniteStateMachine
@onready var interaction_area: InteractionArea = $InteractionArea

var wait_times: Array[float] = [1.0, 1.5, 2.0]
var direction: Vector2 = Vector2.RIGHT
var start_position: Vector2
var player_body

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	
	start_position = position
	dialog_component.character_idle_dialog = character_idle_dialog
	dialog_component.character_dialogs = character_dialogs
	quest_component.char_interact_quest_id = char_interact_quest_id
	super()

func _on_interact():	
	quest_component.manage_deliver_item_quest()
	quest_component.manage_characters_interact_quest()
	dialog_component.curr_dialog_data = quest_component.get_current_dialog_by_quest_complete()	
	await dialog_component.manage_dialog(player_body)


func _on_timer_timeout():
	wait_times.shuffle()
	timer.wait_time = wait_times.front()
	fsm.current_state.transition()
	
func _on_interaction_area_body_entered(body):
	if body is MainCharacter:
		player_body = body
		fsm.force_change_state("player_near_state")

func _on_interaction_area_body_exited(body):
	if body is MainCharacter:
		fsm.change_state(player_near_state, "idle_state")
