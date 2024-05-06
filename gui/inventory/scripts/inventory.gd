extends Control

@onready var tab_container: TabContainer = $TabContainer
@onready var objectives_button: TextureButton = $Buttons/ObjectivesButton
@onready var items_button: TextureButton = $Buttons/ItensButton

enum Tab {
	OBJECTIVES = 0,
	ITEMS = 1
}

var current_tab: Tab = Tab.OBJECTIVES
var is_open: bool = false

signal opened
signal closed

func open() -> void:
	open_tab_objectives()
	visible = true
	is_open = true
	opened.emit()
	
func close() -> void:
	visible = false
	is_open = false
	closed.emit()

func toggle_buttons() -> void:
	objectives_button.disabled = false
	items_button.disabled = false
	
	match current_tab:
		Tab.OBJECTIVES:
			objectives_button.disabled = true
		Tab.ITEMS:
			items_button.disabled = true
				

func open_tab_objectives() -> void:
	current_tab = Tab.OBJECTIVES
	tab_container.current_tab = current_tab
	toggle_buttons()

func open_tab_itens() -> void:
	current_tab = Tab.ITEMS
	tab_container.current_tab = current_tab
	toggle_buttons()

func _on_itens_button_pressed() -> void:
	open_tab_itens()

func _on_objectives_button_pressed() -> void:
	open_tab_objectives()
