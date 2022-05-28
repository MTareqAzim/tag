extends Node
class_name TargetDirection

signal direction_changed(new_direction)

var _target_direction := Vector2(1, 0) setget set_target_direction, get_target_direction


func set_target_direction(new_target_direction) -> void:
	_target_direction = new_target_direction
	emit_signal("direction_changed", _target_direction)


func get_target_direction() -> Vector2:
	return _target_direction
