extends BaseCharacter
class_name CatFollowCharacter

@export_category("Dialog Component")
@export var character_idle_dialog: Dialog = null
@export var character_dialogs: Array[Dialog] = []

@export var animation: AnimationPlayer = null

@onready var dialog_component: DialogComponent = $DialogComponent
@onready var interaction_area: InteractionArea = $InteractionArea

var player_body
var animation_state
var direction: Vector2

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	
	animation_state = $AnimationTree["parameters/playback"]
	dialog_component.character_idle_dialog = character_idle_dialog
	dialog_component.character_dialogs = character_dialogs
	super()

func _on_interact():	
	await dialog_component.manage_dialog(player_body)

func _on_area_2d_body_entered(body):
	animation.play("surprised")
	await animation.animation_finished
	animation.play("shaking")
