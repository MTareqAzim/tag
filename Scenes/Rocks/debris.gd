extends CPUParticles

export(float) var camera_offset := 9.0

var original_origin : Vector3

func _ready():
	original_origin = transform.origin
	emitting = true


func _physics_process(delta):
	var camera = get_viewport().get_camera()
	var camera_position = camera.global_transform.origin
	var difference = global_transform.origin - camera_position
	
	if difference.z < -camera_offset:
		var y_shift = -0.1 * pow(difference.z + camera_offset, 2.0)
		transform.origin.y = original_origin.y + y_shift
	
	if not emitting:
		queue_free()
