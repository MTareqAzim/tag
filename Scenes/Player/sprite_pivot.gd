extends Spatial

export(float) var camera_offset := 9.0

var original_origin : Vector3
var sprites : Array = []


func _ready():
	original_origin = transform.origin
	
	for child in get_children():
		if child is Sprite3D:
			sprites.append(child)


func _physics_process(delta):
	var camera = get_viewport().get_camera()
	var camera_position = camera.global_transform.origin
	var difference = global_transform.origin - camera_position
	
	if difference.z < -camera_offset:
		var y_shift = -0.1 * pow(difference.z + camera_offset, 2.0)
		transform.origin.y = original_origin.y + y_shift


func _on_direction_changed(new_x_direction):
	for sprite in sprites:
		sprite.flip_h = true if new_x_direction == -1 else false
