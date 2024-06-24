extends BaseHumanCharacter
class_name HumanSideCharacter

@export_category("Dialog Component")
@export var character_idle_dialog: Dialog = null
@export var character_dialogs: Array[Dialog] = []
@export var character_color_name: String = ""

@export_subgroup("States")
@export var player_near_state: State = null

@onready var dialog_component: DialogComponent = $DialogComponent
@onready var quest_component: QuestComponent = $QuestComponent
@onready var path_finder_component: PathFinderComponent = $PathFinderComponent
@onready var fsm: FiniteStateMachine = $FiniteStateMachine
@onready var interaction_area: InteractionArea = $InteractionArea

var player_body

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
	dialog_component.character_idle_dialog = character_idle_dialog
	dialog_component.character_dialogs = character_dialogs
	dialog_component.character_color_name = character_color_name
	super()

func _on_interact():
	quest_component.manage_character_quest()
	dialog_component.curr_dialog_data = quest_component.get_current_dialog_by_quest_complete()	
	await dialog_component.manage_dialog(player_body)

func _on_interaction_area_body_entered(body):
	if body is MainCharacter:
		player_body = body
