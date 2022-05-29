extends Spatial


func get_bounds() -> Rect2:
	var size = $Floor/MeshInstance.mesh.size
	size -= Vector2(4.0, 4.0)
	var origin = global_transform.origin
	var position = Vector2(origin.x, origin.z) - size/2.0
	
	return Rect2(position, size)
