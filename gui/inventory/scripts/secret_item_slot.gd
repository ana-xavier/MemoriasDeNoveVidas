extends Panel
class_name SecretItemSlot

@onready var item_shape: TextureRect = $ItemShape
@onready var item_sprite: TextureRect = $ItemSprite

var item: Item
var has_item: bool = false

func _ready():
	item_sprite.visible = false

func add_item_data(item_data: Item):
	item = item_data
	item_shape.texture = item_data.sprite
	item_sprite.texture = item_data.sprite
	
func show_item():
	has_item = true
	item_shape.visible = false
	item_sprite.visible = true
