extends Resource
class_name Item

enum Category {
	BASIC,
	SECRET
}

@export var id: String = ""
@export var name: String = ""
@export var sprite: Texture = null
@export var category: Category = Category.BASIC
