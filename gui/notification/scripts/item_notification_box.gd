extends MarginContainer

@onready var timer = $Timer
@onready var item_name = $MarginContainer/ItemName
@onready var item_sprite = $NinePatchRect/ItemFrame/ItemSprite
@onready var audio_player = $AudioStreamPlayer
@onready var amount_display = $Control/Label

const anim_duration: float = 0.3
const visibility_time = 4 
var final_scale: Vector2 = Vector2.ZERO

var item_buffer = []

func _ready():
	visible = false
	InventoryManager.item_added.connect(self.add_item_to_buffer)

func add_item_to_buffer(_item_name: String, _item_sprite: Texture, amount: int = 1):
	var item_data = {
		"name": _item_name,
		"sprite": _item_sprite,
		"amount": amount	
	}
	item_buffer.append(item_data)
	if timer.is_stopped():
		show_notification()

func show_notification():
	if item_buffer.size() > 0:
		var item = item_buffer.pop_front()
		item_name.text = item["name"]
		item_sprite.texture = item["sprite"]
		var amount = item["amount"]
		if amount > 1:
			amount_display.text = "x" + str(amount)
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
	show_notification()
