extends BaseCharacter
class_name GhostCat

@onready var path_finder_component: PathFinderComponent = $PathFinderComponent
@onready var fsm: FiniteStateMachine = $FiniteStateMachine
@onready var animation: AnimationPlayer = $Animation

var animation_state
var direction: Vector2

func _ready() -> void:
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	animation_state = $AnimationTree["parameters/playback"]
	super()

func _on_spawn(_position: Vector2, _direction):
	var current_level: String = GlobalData.data.current_level
	var char_pos = GlobalData.data.get_character_pos(character_id)
	if !char_pos.is_empty() && current_level:
		if char_pos.get("level") == current_level:
			global_position = char_pos.get("position")
			visible = true
		else:
			queue_free()	

