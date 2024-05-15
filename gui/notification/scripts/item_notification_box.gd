extends MarginContainer

@onready var timer = $Timer
@onready var item_name = $MarginContainer/ItemName
@onready var item_sprite = $NinePatchRect/ItemFrame/ItemSprite
@onready var audio_player = $AudioStreamPlayer

const anim_duration: float = 0.3
const visibility_time = 4 
var final_scale: Vector2 = Vector2.ZERO

func _ready():
	visible = false
	InventoryManager.item_added.connect(self.show_notification)

func show_notification(_item_name: String, _item_sprite: Texture):
	item_name.text = _item_name
	item_sprite.texture = _item_sprite
	visible = true
	timer.start(visibility_time)
	_animate()
	audio_player.play()
	
func _animate() -> void:
	final_scale = scale
	scale = Vector2.ZERO
	var tween = get_tree().create_tween()
	tween.tween_property(
		self, "scale", final_scale, anim_duration
	).set_trans(Tween.TRANS_BACK)
	
func close_item_notification_box():
	visible = false
	
func _on_timer_timeout():
	close_item_notification_box()
