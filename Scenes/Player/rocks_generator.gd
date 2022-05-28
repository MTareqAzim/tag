extends Spatial

var rocks = preload("res://Scenes/Rocks/RocksBody.tscn")


func spawn_rocks(target_direction : Vector2):
	var world : Spatial = get_tree().get_nodes_in_group("world")[0]
	
	if world:
		var rocks_instance = rocks.instance()
		var angle = Vector2.RIGHT.angle_to(target_direction)
		rocks_instance.rotation.y = -angle
		world.add_child(rocks_instance)
		rocks_instance.global_transform.origin = global_transform.origin
