extends EntityStateComponent

export (String) var look_direction_key := "look"
export (String) var target_direction_key := "look_target"

var _look_direction : LookDirection
var _target_direction : TargetDirection


func update(_delta: float) -> void:
	var target_direction = _target_direction.get_target_direction()
	target_direction.x = sign(target_direction.x)
	target_direction.y = round(target_direction.y)
	
	_update_look_direction(target_direction)


func assign_dependencies() -> void:
	_look_direction = component_state.get_dependency(look_direction_key)
	_target_direction = component_state.get_dependency(target_direction_key)


func _update_look_direction(direction: Vector2) -> void:
	if _look_direction.get_look_direction() == direction:
		return
	
	_look_direction.set_look_direction(direction)
