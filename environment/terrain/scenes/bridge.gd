extends Node2D

@export var id: String = ""

@onready var sprite: Sprite2D = $Sprite2D
@onready var broken_collision: CollisionShape2D = $StaticBody2D/BrokenBridgeCollision

enum Frame {
	BROKEN = 0,
	REBUILT = 1
}

func _ready():
	if is_bridge_rebuilt():
		open_bridge()

func is_bridge_rebuilt():
	return InteractiveObjectsData.get_value_in_object(id, "bridge_rebuilt")
	
func open_bridge():
	sprite.frame = Frame.REBUILT
	if broken_collision:
		broken_collision.queue_free()

