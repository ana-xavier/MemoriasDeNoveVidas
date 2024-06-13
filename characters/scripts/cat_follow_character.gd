extends BaseCharacter
class_name CatFollowCharacter

@export_category("Dialog Component")
@export var character_idle_dialog: Dialog = null
@export var character_dialogs: Array[Dialog] = []

@export_category("Quest Component")
@export var char_interact_quest_id: String = ""

@onready var dialog_component: DialogComponent = $DialogComponent
@onready var quest_component: QuestComponent = $QuestComponent
@onready var path_finder_component: PathFinderComponent = $PathFinderComponent
@onready var fsm: FiniteStateMachine = $FiniteStateMachine
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var animation: AnimationPlayer = $Animation

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

func _on_spawn(_position: Vector2, _direction):
	if GlobalData.data.player_has_follower && GlobalData.data.player_followed_by == character_id:
		global_position = _position
		global_position.x += 10
		visible = true
		fsm.force_change_state("idle_follow_player_state")
		return
	
	var current_level: String = GlobalData.data.current_level
	var char_pos = GlobalData.data.get_character_pos(character_id)
	if !char_pos.is_empty() && current_level:
		if char_pos.get("level") == current_level:
			global_position = char_pos.get("position")
			visible = true
		else:
			queue_free()	
	
func _on_interaction_area_body_entered(body):
	if body is MainCharacter:
		player_body = body
