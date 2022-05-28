extends EntityStateComponent

export (String) var target_direction_key := "target"
export (String) var dash_distance_key := "dash_distance"
export (String) var dash_duration_key := "dash_duration"
export (bool) var x_direction_only = false

var _target_direction : TargetDirection
var _dash_distance : float
var _dash_duration : float


func enter() -> void:
	_set_values()


func assign_dependencies() -> void:
	_target_direction = component_state.get_dependency(target_direction_key)


func assign_variables() -> void:
	_dash_distance = component_state.get_variable(dash_distance_key)
	_dash_duration = component_state.get_variable(dash_duration_key)


func _set_values() -> void:
	var speed : float = _dash_distance / _dash_duration
	var direction : Vector2 = _target_direction.get_target_direction()
	direction = direction.normalized()
	
	$"Velocity2D".args = [direction * speed]
	$"TargetVelocity2D".args = [Vector2.ZERO]

