extends RigidBody

export var speed_threshold := 5.0


func _ready():
	$AnimationPlayer.play("enter")


func crumble():
	queue_free()


func _on_area_entered(area):
	if not area.has_method("get_body_speed"):
		return
	
	var incoming_body_speed = area.get_body_speed()
	
	if incoming_body_speed >= speed_threshold:
		crumble()
