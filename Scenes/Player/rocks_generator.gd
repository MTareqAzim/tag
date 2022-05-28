extends Spatial

var rocks = preload("res://Scenes/Rocks/RocksBody.tscn")


func spawn_rocks(target_direction : Vector2):
	var world : Spatial = get_tree().get_nodes_in_group("world")[0]
	
	if world:
		var rocks_instance = rocks.instance()
		var angle = Vector2.RIGHT.angle_to(target_direction)
		rocks_instance.rotation.y = -angle
		rocks_instance.global_transform.origin = global_transform.origin
		world.add_child(rocks_instance)
