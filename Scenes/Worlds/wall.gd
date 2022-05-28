extends StaticBody

export(float) var stun_threshold := 6.0


func _on_area_entered(area):
	if not area.has_method("get_body_speed"):
		return
	
	if not area.has_method("stun_body"):
		return
	
	var incoming_body_speed = area.get_body_speed()
	
	if incoming_body_speed >= stun_threshold:
		area.stun_body()
