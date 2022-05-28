extends EntityStateComponent

export (String) var input_handler_key := "input"
export (String) var target_direction_key := "target"

var _input_handler : InputHandler
var _target_direction : TargetDirection


func update(_delta: float) -> void:
	var mouse_direction = _input_handler.get_mouse_position().normalized()
	_update_target_direction(Vector2(mouse_direction.x, mouse_direction.z))


func assign_dependencies() -> void:
	_input_handler = component_state.get_dependency(input_handler_key)
	_target_direction = component_state.get_dependency(target_direction_key)


func _update_target_direction(direction: Vector2) -> void:
	if _target_direction.get_target_direction() == direction:
		return
	
	_target_direction.set_target_direction(direction)
