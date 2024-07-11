extends CanvasLayer

@onready var top_bar: ColorRect = $TopBar
@onready var bottom_bar: ColorRect = $BottomBar
@onready var full_screen_fade: ColorRect = $FullScreenFade

const BAR_SIZE = Vector2(320, 22.5)
const DEFAULT_BAR_SIZE = Vector2(320, 0)
const ANIMATION_DURATION = 0.8

var is_cutscene_running: bool = false
var hided_bars: bool = false

signal cutscene_started
signal cutscene_ended

func _ready():
	visible = false
	full_screen_fade.visible = false
	top_bar.size.y = 0
	bottom_bar.size.y = 0

func start_cutscene(hide_bars: bool = false) -> void:
	cutscene_started.emit()
	is_cutscene_running = true
	
	if hide_bars:
		hided_bars = true
		return
	
	visible = true
	var tween_top = get_tree().create_tween()
	tween_top.tween_property(
		top_bar, "size", BAR_SIZE, ANIMATION_DURATION
	).set_trans(Tween.TRANS_LINEAR)
	
	var tween_bottom = get_tree().create_tween()
	tween_bottom.tween_property(
		bottom_bar, "size", BAR_SIZE, ANIMATION_DURATION
	).set_trans(Tween.TRANS_LINEAR)
	
	
func end_cutscene() -> void:
	
	if !hided_bars:
		var tween_top = get_tree().create_tween()
		tween_top.tween_property(
			top_bar, "size", DEFAULT_BAR_SIZE, ANIMATION_DURATION
		).set_trans(Tween.TRANS_LINEAR)
		
		var tween_bottom = get_tree().create_tween()
		tween_bottom.tween_property(
			bottom_bar, "size", DEFAULT_BAR_SIZE, ANIMATION_DURATION
		).set_trans(Tween.TRANS_LINEAR)
		await  tween_bottom.finished
		
	hided_bars = false	
	visible = false
	is_cutscene_running = false
	cutscene_ended.emit()
	
func full_screen_fade_in(duration: float = 1.0, wait_time: float = 0.0) -> void:
	await get_tree().create_timer(wait_time).timeout
	var tween = create_tween()
	tween.tween_property(
		full_screen_fade, "color:a", 0, duration
	).set_trans(Tween.TRANS_LINEAR)
	await tween.finished
	full_screen_fade.visible = false
	
func full_screen_fade_out(duration: float = 1.0, wait_time: float = 0.0) -> void:
	full_screen_fade.visible = true
	var tween = create_tween()
	tween.tween_property(
		full_screen_fade, "color:a", 1, duration
	).set_trans(Tween.TRANS_LINEAR)
	await tween.finished
	await get_tree().create_timer(wait_time).timeout
