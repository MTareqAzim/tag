extends EntityStateComponent

export (String) var rocks_spawner_key := "rocks"
export (String) var target_direction_key := "target"

var _rocks_spawner : Spatial
var _target_direction : TargetDirection


func enter():
	var target_direction = _target_direction.get_target_direction()
	_rocks_spawner.spawn_rocks(target_direction)


func assign_dependencies() -> void:
	_rocks_spawner = component_state.get_dependency(rocks_spawner_key)
	_target_direction = component_state.get_dependency(target_direction_key)
