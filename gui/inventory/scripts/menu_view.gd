extends Control

@onready var save_view: Control = $TabContainer/SaveView
@onready var load_view: VBoxContainer = $TabContainer/LoadView/LoadGameList

@onready var tab_container: TabContainer = $TabContainer
@onready var save_button: TextureButton = $MenuButtons/SaveButton
@onready var load_button: TextureButton = $MenuButtons/LoadButton
@onready var options_button: TextureButton = $MenuButtons/OptionsButton
@onready var quit_button: TextureButton = $MenuButtons/MarginContainer/QuitButton

enum Tab {
	EMPTY = 0,
	SAVE = 1,
	LOAD = 2,
	OPTIONS = 3
}

var current_tab: Tab = Tab.EMPTY

func open() -> void:
	open_tab_empty()
	
func toggle_buttons() -> void:
	save_button.disabled = false
	load_button.disabled = false
	options_button.disabled = false
	
	match current_tab:
		Tab.SAVE:
			save_button.disabled = true
		Tab.LOAD:
			load_button.disabled = true
		Tab.OPTIONS:
			options_button.disabled = true
				

func open_tab_empty() -> void:
	current_tab = Tab.EMPTY
	tab_container.current_tab = current_tab
	toggle_buttons()

func open_tab_save() -> void:
	save_view.search_saved_data()
	current_tab = Tab.SAVE
	tab_container.current_tab = current_tab
	toggle_buttons()

func open_tab_load() -> void:
	load_view.open()
	current_tab = Tab.LOAD
	tab_container.current_tab = current_tab
	toggle_buttons()
	
func open_tab_options() -> void:
	# MOSTRAR OPTIONS
	current_tab = Tab.OPTIONS
	tab_container.current_tab = current_tab
	toggle_buttons()


func _on_save_button_pressed():
	open_tab_save()

func _on_load_button_pressed():
	open_tab_load()

func _on_options_button_pressed():
	open_tab_options()

func _on_quit_button_pressed():
	SignalBus.open_feedback_container.emit("Você deseja sair do jogo? Dados não\nsalvos serão perdidos!", true, true)
	var message = await SignalBus.feedback_returned
	if message == "confirm":
		get_tree().quit()

