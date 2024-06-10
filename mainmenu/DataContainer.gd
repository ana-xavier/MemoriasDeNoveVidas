extends Control

@onready var title: Label = $TextureRect/Label
@onready var tab_container: TabContainer = $MarginContainer/MarginContainer/NewGameAndLoadTab
@onready var new_game_list: VBoxContainer = $MarginContainer/MarginContainer/NewGameAndLoadTab/NewGameList
@onready var load_game_list: VBoxContainer = $MarginContainer/MarginContainer/NewGameAndLoadTab/LoadGameList

enum Tab {
	NEW_GAME = 0,
	LOAD = 1
}

func open_new_game_tab():
	new_game_list.open()
	tab_container.current_tab = Tab.NEW_GAME
	if !new_game_list.is_slots_empty:
		title.text = "Novo Jogo"
		visible = true

func open_load_game_tab():
	load_game_list.open()
	tab_container.current_tab = Tab.LOAD
	title.text = "Continuar"
	visible = true
	
func _on_close_button_pressed():
	visible = false 
