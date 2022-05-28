extends Spatial


func _update_angle(direction):
	var pivot_angle = Vector2.RIGHT.angle_to(direction)
	rotation.y = -pivot_angle
