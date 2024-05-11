extends MarginContainer

@onready var timer = $Timer
@onready var item_name = $MarginContainer/ItemName
@onready var item_sprite = $NinePatchRect/ItemFrame/ItemSprite
@onready var audio_player = $AudioStreamPlayer

var visibility_time = 4 

func _ready():
	visible = false
	InventoryManager.item_added.connect(self.show_notification)

func show_notification(_item_name: String, _item_sprite: Texture):
	item_name.text = _item_name
	item_sprite.texture = _item_sprite
	visible = true
	timer.start(visibility_time)
	audio_player.play()
	
func close_item_notification_box():
	visible = false
	
func _on_timer_timeout():
	close_item_notification_box()
