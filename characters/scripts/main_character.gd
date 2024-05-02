extends CharacterBody2D

class_name MainCharacter

var _state_machine

@onready var animation_player: AnimationPlayer = $Animation

@export_category("Variables")
@export var _move_speed: float = 54.0
@export var _acceleration: float = 0.2
@export var _friction: float = 0.2

@export_category("Objects")
@export var _animation_tree: AnimationTree = null


func _ready() -> void:
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	
	_state_machine = _animation_tree["parameters/playback"]
	self.scale = Vector2(0.6, 0.6)
	
func _physics_process(_delta: float) -> void:
	_animate()
	
	if DialogManager.is_dialog_active or InteractionHoldManager.is_holding:
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
		return
	
	velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _friction)
	velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _friction)
	

func _animate() -> void:
	if(velocity.length() > 2 && not DialogManager.is_dialog_active && not InteractionHoldManager.is_holding):
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
	
func _on_spawn(positioon: Vector2, direction: String):
	global_position = positioon
