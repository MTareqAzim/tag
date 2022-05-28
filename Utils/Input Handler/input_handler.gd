extends Node
class_name InputHandler


func get_mouse_position() -> Vector2:
	return get_viewport().get_mouse_position()


func get_direction() -> Vector2:
	return Vector2()


func is_action_pressed(_action: String) -> bool:
	return false
