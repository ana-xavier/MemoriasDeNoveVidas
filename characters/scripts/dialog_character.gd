extends BaseCharacter
class_name DialogCharacter

@export_category("Dialog Component")
@export var character_idle_dialog: Dialog = null
@export var character_dialogs: Array[Dialog] = []

@onready var dialog_component: DialogComponent = $DialogComponent
@onready var interaction_area: InteractionArea = $InteractionArea

var player_body

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	
	dialog_component.character_idle_dialog = character_idle_dialog
	dialog_component.character_dialogs = character_dialogs
	super()

func _on_interact():	
	await dialog_component.manage_dialog(player_body)

func _on_interaction_area_body_entered(body):
	if body is MainCharacter:
		player_body = body
