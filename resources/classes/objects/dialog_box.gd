extends Resource
class_name DialogBox

enum Character {
	PLAYER,
	NPC
}

@export var character_type: Character = 0
@export var lines: Array[String] = []
