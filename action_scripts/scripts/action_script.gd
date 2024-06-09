extends Node
class_name ActionScript

func _init():
	if self.get_class() == "ActionScript":
		push_error("ActionScript is an abstract class and cannot be instantiated directly")

func run(_trigger_node: Node2D, _body: CharacterBody2D) -> bool:
	push_error("run() must be implemented in the derived class")
	return false
