extends Control

@onready var objectives_view: Control = $TabContainer/ObjectivesView
@onready var menu_view: Control = $TabContainer/MenuView

@onready var tab_container: TabContainer = $TabContainer
@onready var objectives_button: TextureButton = $Buttons/ObjectivesButton
@onready var items_button: TextureButton = $Buttons/ItensButton
@onready var menu_button: TextureButton = $Buttons/MenuButton
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

@export_category("Sounds")
@export var popup_sound: AudioStreamWAV = null
@export var popdown_sound: AudioStreamWAV = null
@export var change_tab_sound: AudioStreamWAV = null

enum Tab {
	OBJECTIVES = 0,
	ITEMS = 1,
	MENU = 2
}

var current_tab: Tab = Tab.OBJECTIVES
var is_open: bool = false

signal opened
signal closed

func _ready():
	visible = false
	SignalBus.loading_level.connect(close)

func open() -> void:
	open_tab_objectives()
	visible = true
	is_open = true
	audio_player.stream = popup_sound
	audio_player.play()
	opened.emit()

func open_menu() -> void:
	open_tab_menu()
	visible = true
	is_open = true
	audio_player.stream = popup_sound
	audio_player.play()
	opened.emit()
	
func close() -> void:
	visible = false
	is_open = false
	audio_player.stream = popdown_sound
	audio_player.play()
	closed.emit()

func toggle_buttons() -> void:
	objectives_button.disabled = false
	items_button.disabled = false
	menu_button.disabled = false
	
	match current_tab:
		Tab.OBJECTIVES:
			objectives_button.disabled = true
		Tab.ITEMS:
			items_button.disabled = true
		Tab.MENU:
			menu_button.disabled = true
				

func open_tab_objectives() -> void:
	objectives_view.update_displayed_objectives()
	current_tab = Tab.OBJECTIVES
	tab_container.current_tab = current_tab
	toggle_buttons()

func open_tab_itens() -> void:
	current_tab = Tab.ITEMS
	tab_container.current_tab = current_tab
	toggle_buttons()

func open_tab_menu() -> void:
	menu_view.open()
	current_tab = Tab.MENU
	tab_container.current_tab = current_tab
	toggle_buttons()

func _on_itens_button_pressed() -> void:
	audio_player.stream = change_tab_sound
	audio_player.play()
	open_tab_itens()

func _on_objectives_button_pressed() -> void:
	audio_player.stream = change_tab_sound
	audio_player.play()
	open_tab_objectives()

func _on_menu_button_pressed():
	audio_player.stream = change_tab_sound
	audio_player.play()
	open_tab_menu()

func _on_texture_button_pressed():
	close()
