extends Panel

@onready var item_sprite: TextureRect = $ItemSprite
@onready var slot_toggle: Sprite2D = $SlotToggle
@onready var amount_label: Label = $ItemSprite/Amount

var item: Item
	
func display_item(item_data: Item, amount: int):
	item = item_data
	item_sprite.texture = item_data.sprite
	slot_toggle.frame = 0
	
	if amount > 1:
		amount_label.text = str(amount)
	
func clear():
	item = null
	item_sprite.texture = null
	amount_label.text = ""
	slot_toggle.frame = 1
	item_sprite.scale = Vector2(1.0, 1.0)


func _on_mouse_entered():
	item_sprite.scale = Vector2(1.05, 1.05)


func _on_mouse_exited():
	item_sprite.scale = Vector2(1.0, 1.0)
