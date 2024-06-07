extends CanvasLayer

@onready var top_bar: ColorRect = $TopBar
@onready var bottom_bar: ColorRect = $BottomBar

const BAR_SIZE = Vector2(320, 22.5)
const DEFAULT_BAR_SIZE = Vector2(320, 0)
const ANIMATION_DURATION = 0.8

var player: MainCharacter = null
var is_cutscene_running: bool = false

signal cutscene_started
signal cutscene_ended

func _ready():
	visible = false
	top_bar.size.y = 0
	bottom_bar.size.y = 0

func start_cutscene() -> void:
	cutscene_started.emit()
	player = get_tree().get_first_node_in_group("player") as MainCharacter
	player.lock_player_movement()
	visible = true
	is_cutscene_running = true
	
	var tween_top = get_tree().create_tween()
	tween_top.tween_property(
		top_bar, "size", BAR_SIZE, ANIMATION_DURATION
	).set_trans(Tween.TRANS_LINEAR)
	
	var tween_bottom = get_tree().create_tween()
	tween_bottom.tween_property(
		bottom_bar, "size", BAR_SIZE, ANIMATION_DURATION
	).set_trans(Tween.TRANS_LINEAR)
	
	
func end_cutscene() -> void:
	var tween_top = get_tree().create_tween()
	tween_top.tween_property(
		top_bar, "size", DEFAULT_BAR_SIZE, ANIMATION_DURATION
	).set_trans(Tween.TRANS_LINEAR)
	
	var tween_bottom = get_tree().create_tween()
	tween_bottom.tween_property(
		bottom_bar, "size", DEFAULT_BAR_SIZE, ANIMATION_DURATION
	).set_trans(Tween.TRANS_LINEAR)
	
	await  tween_bottom.finished
	player.unlock_player_movement()
	visible = false
	is_cutscene_running = false
	cutscene_ended.emit()
	
