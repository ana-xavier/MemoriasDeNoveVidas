extends Node2D
class_name BaseCharacter

@onready var sprite: Sprite2D = $Sprite
@onready var timer: Timer = $Timer

@export_category("Base Character")
@export var character_id: String = ""
@export var character_name: String = "???"
@export var texture: Texture2D = null
@export var frame: int = 50

@export_category("Character Movement")
@export var is_character_static: bool = false
@export var _animation: AnimationPlayer = null
@export var speed: int = 20
@export var max_distance_from_start: float = 35.0

# Probabilities
const IDLE_TO_NEW_DIR_PROB: float = 0.7
const NEW_DIR_TO_MOVING_PROB: float = 0.8
const MOVING_TO_IDLE_PROB: float = 0.6
const NEW_DIR_ANIM_PROB: float = 0.4

enum {
	IDLE, 
	NEW_DIR,
	MOVING
}

var wait_times: Array[float] = [1.0, 1.5, 2.0]
var direction: Vector2 = Vector2.RIGHT
var start_position: Vector2

var current_state = IDLE
var already_in_idle: bool = true
var already_in_new_dir: bool = false

func _ready() -> void:
	randomize()
	start_position = position
	
	if texture != null:
		sprite.texture = texture
		sprite.frame = frame


func _process(delta):
	if is_character_static:
		return
	
	_animate()
	match  current_state:
		IDLE:
			pass
		NEW_DIR:
			direction = choose_random_value([Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN])
		MOVING:
			_move(delta)


func _animate():
	# Idle animation
	if current_state == IDLE && !already_in_idle:
		already_in_idle = true
		if direction == Vector2.UP || direction == Vector2.DOWN:
			_animation.play("sitting_down")
		if direction == Vector2.LEFT:
			_animation.play("sitting_left")
		if direction == Vector2.RIGHT:
			_animation.play("sitting_right")
		
	# New direction animation
	elif current_state == NEW_DIR && !already_in_new_dir:
		already_in_new_dir = true
		if randf() < NEW_DIR_ANIM_PROB:
			if direction == Vector2.UP || direction == Vector2.DOWN:
				_animation.play("idle_down")
			if direction == Vector2.LEFT:
				_animation.play("idle_left")
			if direction == Vector2.RIGHT:
				_animation.play("idle_right")
			
	# Moving animation
	elif  current_state == MOVING:
		already_in_idle = false
		already_in_new_dir = false
		
		if direction.x == -1:
			_animation.play("walking_left")
		if direction.x == 1:
			_animation.play("walking_right")
		if direction.y == -1:
			_animation.play("walking_up")
		if direction.y == 1:
			_animation.play("walking_down")


func _move(delta):
	var new_position = position + direction * speed * delta
	var distance_from_start = new_position.distance_to(start_position)

	if distance_from_start <= max_distance_from_start:
		position = new_position
	else:
		current_state = IDLE


func choose_random_value(array: Array):
	array.shuffle()
	return array.front()


func _choose_new_state() -> void:
	match current_state:
		IDLE:
			if randf() < IDLE_TO_NEW_DIR_PROB:
				current_state = NEW_DIR
		NEW_DIR:
			if randf() < NEW_DIR_TO_MOVING_PROB:
				current_state = MOVING
		MOVING:
			if randf() < MOVING_TO_IDLE_PROB:
				current_state = IDLE


func _on_timer_timeout():
	timer.wait_time = choose_random_value(wait_times)
	_choose_new_state()
