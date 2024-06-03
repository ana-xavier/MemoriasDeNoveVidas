extends Resource
class_name DialogBox

enum Character {
	PLAYER,
	NPC
}

@export var character_type: Character = Character.PLAYER
@export var lines: Array[String] = []
