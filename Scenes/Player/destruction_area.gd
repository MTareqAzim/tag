extends Area

export var body_path : NodePath

onready var _body : Entity = get_node(body_path)


func get_body_speed() -> float:
	var body_velocity = _body.get_velocity_2d()
	var body_speed = body_velocity.length()
	
	return body_speed
