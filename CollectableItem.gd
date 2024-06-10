extends Node2D

@export var id_item: String = ""
@export var sprite_item: Texture = null
@export var id: String = ""

@onready var sprite_node: Sprite2D = $Sprite2D
@onready var interaction_area: InteractionArea = $InteractionArea

func _ready():
	if (InteractiveObjectsData.is_object_already_interacted(id)):
		queue_free()
	if sprite_item != null:
		sprite_node.texture = sprite_item
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact():
	InteractiveObjectsData.set_object_already_interacted(id)
	InventoryManager.add_item(id_item)
	queue_free()
	

