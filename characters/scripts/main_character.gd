extends CharacterBody2D

class_name MainCharacter

var _state_machine

@onready var animation_player: AnimationPlayer = $Animation
@onready var front_collision: Area2D = $FrontCollision

@export_category("Variables")
@export var _move_speed: float = 54.0
@export var _acceleration: float = 0.2
@export var _friction: float = 0.2

@export_category("Objects")
@export var _animation_tree: AnimationTree = null

var is_jumping: bool = false
var is_player_locked: bool = false

func _ready() -> void:
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	SignalBus.opened_content_container.connect(lock_player_movement)
	SignalBus.closed_content_container.connect(unlock_player_movement)
	
	_state_machine = _animation_tree["parameters/playback"]
	
func _physics_process(_delta: float) -> void:
	_animate()
	
	if (DialogManager.is_dialog_active 
		|| InteractionHoldManager.is_holding
		|| is_player_locked
		|| is_jumping
		):
		return
		
	_move()
	move_and_slide()
	
func _move() -> void:
	var _direction: Vector2 = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	
	if _direction != Vector2.ZERO:
		_animation_tree["parameters/Idle/blend_position"] = _direction
		_animation_tree["parameters/Running/blend_position"] = _direction
		_animation_tree["parameters/DiggingPrepar/blend_position"] = _direction
		_animation_tree["parameters/Digging/blend_position"] = _direction
		
		velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _acceleration)
		velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _acceleration)
		front_collision.rotation = _direction.angle()
		return
		
	
	velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _friction)
	velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _friction)
	

func _animate() -> void:
	if is_jumping:
		return
	
	if(velocity.length() > 2
		 && !DialogManager.is_dialog_active
		 && !InteractionHoldManager.is_holding
		 && !is_player_locked
		):
		_state_machine.travel("Running")
		return
		
	if(InteractionHoldManager.is_holding && 
		InteractionHoldManager.curr_interactionType == InteractionHoldManager.HoldType.DIGGING):
			var timer = InteractionHoldManager.timer
			if timer.wait_time - 0.6 < timer.time_left: 
				_state_machine.travel("DiggingPrepar")
			else:
				_state_machine.travel("Digging")	
			return
			
	_state_machine.travel("Idle")

func _on_jump(destination: Marker2D):
	is_jumping = true
	
	if destination.global_position.x > global_position.x:
		_state_machine.travel("jumping_right")
	else:
		_state_machine.travel("jumping_left")
	#
	var tween = get_tree().create_tween()
	tween.tween_property(
		self, "position", destination.global_position, 0.4
	)
	await tween.finished
	is_jumping = false
	
func _on_spawn(position: Vector2, direction: String):
	global_position = position

func lock_player_movement():
	is_player_locked = true
	
func unlock_player_movement():
	is_player_locked = false
