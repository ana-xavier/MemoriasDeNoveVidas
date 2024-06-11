extends CanvasLayer

@onready var inventory: Control = $Inventory
@onready var note_popup: Control = $NotePopup
@onready var content_container: Control = $ContentContainer

func _ready():
	CutsceneManager.cutscene_started.connect(hide_canvas_layer)
	CutsceneManager.cutscene_ended.connect(show_canvas_layer)

func _input(event):
	if event.is_action_pressed("inventory_toggle"):
		if is_another_component_open() || CutsceneManager.is_cutscene_running:
			return
		if inventory.is_open:
			inventory.close()
		else:
			inventory.open()
	elif event.is_action_pressed("menu"):
		if is_another_component_open() || CutsceneManager.is_cutscene_running:
			return
		if !inventory.is_open:
			inventory.open_menu()
		else:
			inventory.close()
	
func is_another_component_open() -> bool:
	if note_popup.is_open ||  content_container.is_open:
		return true
	return false

func _on_inventory_button_pressed():
	if !inventory.is_open:
		inventory.open()

func hide_canvas_layer():
	visible = false
	
func show_canvas_layer():
	visible = true
