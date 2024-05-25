extends BaseCharacter
class_name DialogCharacter

@onready var interaction_area: InteractionArea = $InteractionArea

@export_category("Dialogs")
@export var character_dialogs: Array[Dialog] = []
@export var character_idle_dialog: Dialog = null

enum Character {
	PLAYER,
	NPC
}

var curr_dialog_data: Dialog = null

var player_body
var player_in_dialog_zone: bool = false
var player_was_left: bool = false
var player_was_right: bool = false


func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	super()

func _process(delta):
	if is_character_static:
		return
		
	if player_in_dialog_zone:
		dialog_animation()
		return
		
	super(delta)

func dialog_animation():
	if global_position.x >= player_body.global_position.x && !player_was_left:
		_animation.play("sitting_left")
		player_was_left = true
		player_was_right = false
	elif global_position.x < player_body.global_position.x && !player_was_right:
		_animation.play("sitting_right")
		player_was_left = false
		player_was_right = true
		
	current_state = IDLE
		
func _on_interact():	
	await manage_dialog()

func manage_dialog() -> void:
	if !curr_dialog_data:
		curr_dialog_data = get_current_dialog()
		
	var dialog_boxes: Array[DialogBox] = curr_dialog_data.dialog

	for dialog in dialog_boxes:
		var curr_character = character_name if dialog.character_type == Character.NPC else GlobalData.main_character_name
		var curr_position =  global_position if dialog.character_type == Character.NPC else player_body.global_position
		var curr_lines: Array[String] =  dialog.lines
		
		DialogManager.start_dialog(curr_position, curr_lines, curr_character)
		await DialogManager.dialog_finished

	DialogData.set_dialog_already_done(curr_dialog_data.id)
	search_quest_in_dialog()
	curr_dialog_data = null


func get_current_dialog() -> Dialog:
	var dialog_id: String = DialogData.get_curr_dialog_by_character_id(character_id)
	
	for dialog in character_dialogs:
		if dialog.id == dialog_id:
			return dialog
	return character_idle_dialog	


func search_quest_in_dialog() -> void:
	if curr_dialog_data.release_a_quest:
		var quest_id = curr_dialog_data.quest_id
		QuestManager.set_quest_active(quest_id) 


func _on_interaction_area_body_entered(body):
	if body is MainCharacter:
		player_body = body
		player_in_dialog_zone = true

func _on_interaction_area_body_exited(body):
	if body is MainCharacter:
		player_in_dialog_zone = false
		player_was_left = false
		player_was_right = false
