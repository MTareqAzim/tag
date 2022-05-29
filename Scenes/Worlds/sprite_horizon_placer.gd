extends Sprite3D

export(float) var camera_offset := 9.0
export(float) var x_multiplier := 0.1

var original_origin : Vector3
var original_difference : Vector3
var original_camera_origin : Vector3

func _ready():
	original_origin = transform.origin
	
	var camera = get_viewport().get_camera()
	original_camera_origin = camera.global_transform.origin
	original_difference = original_origin - original_camera_origin


func _process(delta):
	var camera = get_viewport().get_camera()
	var camera_origin = camera.global_transform.origin
	var difference = global_transform.origin - camera_origin
	
	if difference.z < -(camera_offset + 2.8):
		var y_shift = (difference.z + camera_offset + 1.45) * tan(deg2rad(-30.0))
		transform.origin.y = original_origin.y - y_shift
	elif difference.z < -camera_offset:
		var y_shift = -0.1 * pow(difference.z + camera_offset, 2.0)
		transform.origin.y = original_origin.y + y_shift
	
	var camera_difference = camera_origin - original_camera_origin
	var x_shift = (camera_difference.x * (1 - x_multiplier))
	transform.origin.x = original_origin.x + x_shift
