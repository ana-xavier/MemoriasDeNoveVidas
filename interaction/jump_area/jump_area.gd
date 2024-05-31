extends Node2D

@export_category("Collision")
@export var from_collision_mask: int = 1
@export var to_collision_mask: int = 1

@export_category("Z-index")
@export var from_z_index: int = 0
@export var to_z_index: int = 0

@onready var from_surface: InteractionJumpArea = $FromSurface
@onready var source: Marker2D = $FromSurface/Source

@onready var to_surface: InteractionJumpArea = $ToSurface
@onready var destination: Marker2D = $ToSurface/Destination

@onready var player_body = get_tree().get_first_node_in_group("player") as MainCharacter 

func _ready():
	from_surface.interact = Callable(self, "_from_surface_jump")
	to_surface.interact = Callable(self, "_to_surface_jump")
	
	from_surface.collision_mask_layer = from_collision_mask
	to_surface.collision_mask_layer = to_collision_mask

func _from_surface_jump():
	if player_body:
		player_body.set_collision_mask_value(to_collision_mask, 0)
		player_body.set_collision_mask_value(from_collision_mask, 1)
		await player_body._on_jump(source)
		player_body.z_index = from_z_index

func _to_surface_jump():
	if player_body:
		player_body.set_collision_mask_value(from_collision_mask, 0)
		player_body.set_collision_mask_value(to_collision_mask, 1)
		player_body.z_index = to_z_index
		await player_body._on_jump(destination)


