extends CanvasLayer

@onready var inventory: Control = $Inventory
@onready var note_popup: Control = $NotePopup
@onready var content_container: Control = $ContentContainer

func _input(event):
	if event.is_action_pressed("inventory_toggle"):
		if is_another_component_open():
			return
		if inventory.is_open:
			inventory.close()
		else:
			inventory.open()

func is_another_component_open() -> bool:
	if note_popup.is_open ||  content_container.is_open:
		return true
	return false

func _on_inventory_button_pressed():
	if !inventory.is_open:
		inventory.open()
