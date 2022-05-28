extends Spatial

var ray_scores : Dictionary = {
	Vector2.RIGHT: 0.0,
	Vector2.RIGHT.rotated(PI/6.0): 0.0,
	Vector2.RIGHT.rotated(PI/3.0): 0.0,
	Vector2.UP: 0.0,
	Vector2.UP.rotated(PI/6.0): 0.0,
	Vector2.UP.rotated(PI/3.0): 0.0,
	Vector2.LEFT: 0.0,
	Vector2.LEFT.rotated(PI/6.0): 0.0,
	Vector2.LEFT.rotated(PI/3.0): 0.0,
	Vector2.DOWN: 0.0,
	Vector2.DOWN.rotated(PI/6.0): 0.0,
	Vector2.DOWN.rotated(PI/3.0): 0.0
}

var _layers : int = 0

export(float) var cast_distance := 3.0
export(Array, int) var layers 


func _ready():
	for layer in layers:
		_layers += pow(2, layer)


func _physics_process(delta):
	var space_state = get_world().direct_space_state
	
	for direction in ray_scores.keys():
		var end_point = global_transform.origin + (Vector3(direction.x, 0.0, direction.y) * cast_distance)
		var result = space_state.intersect_ray(global_transform.origin, end_point, [], _layers, true, false)
		
		if result:
			var distance = global_transform.origin.distance_to(result["position"])
			var score = distance / cast_distance
			ray_scores[direction] = score
		else:
			ray_scores[direction] = 1.0


func get_ray_scores() -> Dictionary:
	return ray_scores
