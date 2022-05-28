extends Node
class_name InputHandler


func get_mouse_position() -> Vector3:
	var mouse_pos = get_viewport().get_mouse_position()
	
	return Vector3(mouse_pos.x, 0.0, mouse_pos.y)


func get_direction() -> Vector2:
	return Vector2()


func is_action_pressed(_action: String) -> bool:
	return false
