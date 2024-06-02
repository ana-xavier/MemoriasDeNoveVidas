extends BaseCharacter
class_name CatFollowCharacter

@export_category("Dialog Component")
@export var character_idle_dialog: Dialog = null
@export var character_dialogs: Array[Dialog] = []

@export_category("Quest Component")
@export var char_interact_quest_id: String = ""

@export var animation: AnimationPlayer = null

@onready var dialog_component: DialogComponent = $DialogComponent
@onready var quest_component: QuestComponent = $QuestComponent
@onready var fsm: FiniteStateMachine = $FiniteStateMachine
@onready var interaction_area: InteractionArea = $InteractionArea

var player_body
var animation_state
var direction: Vector2

func _ready() -> void:
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	interaction_area.interact = Callable(self, "_on_interact")
	
	animation_state = $AnimationTree["parameters/playback"]
	dialog_component.character_idle_dialog = character_idle_dialog
	dialog_component.character_dialogs = character_dialogs
	quest_component.char_interact_quest_id = char_interact_quest_id		
	super()

func _on_interact():	
	quest_component.manage_character_quest()
	quest_component.manage_characters_interact_quest()
	dialog_component.curr_dialog_data = quest_component.get_current_dialog_by_quest_complete()	
	await dialog_component.manage_dialog(player_body)

func _on_spawn(position: Vector2, direction):
	if GlobalData.data.player_has_follower && GlobalData.data.player_followed_by == character_id:
		global_position = position
		global_position.x += 10
		visible = true
		fsm.force_change_state("follow_player_state")
