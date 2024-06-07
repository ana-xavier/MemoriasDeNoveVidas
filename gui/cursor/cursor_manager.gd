extends CanvasLayer

@export var empty_cursor: Texture = null
@export var default_cursor: Texture = null

@onready var cursor: Sprite2D = $Cursor

func _ready():
	Input.set_custom_mouse_cursor(empty_cursor, Input.CURSOR_ARROW)
	CutsceneManager.cutscene_started.connect(hide_cursor)
	CutsceneManager.cutscene_ended.connect(show_cursor)

func _process(delta):
	cursor.global_position = cursor.get_global_mouse_position()

func hide_cursor() -> void:
	cursor.hide()

func show_cursor() -> void:
	cursor.show()
