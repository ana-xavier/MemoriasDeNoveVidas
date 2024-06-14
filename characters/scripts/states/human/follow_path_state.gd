extends State

@export var body: BaseHumanCharacter = null
@export var path_finder_component: PathFinderComponent = null
@export var animation_player: AnimationPlayer = null

func enter():
	animation_player.stop()

func update(_delta: float):
	if path_finder_component.is_following_path:
		var direction = path_finder_component.direction
		
		if direction != Vector2.ZERO:
			if direction.x < 0:
				animation_player.play("walking_left")
			elif direction.x > 0:
				animation_player.play("walking_right")
			else:
				if direction.y > 0:
					animation_player.play("walking_down")
				if direction.y < 0:
					animation_player.play("walking_up")
				
