extends Spatial


func shake():
	var camera = get_viewport().get_camera()
	if camera.has_method("shake"):
		camera.shake()
