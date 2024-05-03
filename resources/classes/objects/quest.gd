extends Resource
class_name Quest

enum Status {
	INACTIVE,
	ACTIVE,
	COMPLETE
}

@export var id: String = ""
@export var name: String = ""
@export var description: String = ""
@export var status: Status = Status.INACTIVE
@export var has_prerequisite: bool = false
@export var prerequisite_quest_id: String = ""
	
	
