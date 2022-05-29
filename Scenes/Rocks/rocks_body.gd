extends RigidBody

var debris = preload("res://Scenes/Rocks/Debris.tscn")

export var speed_threshold := 10.0
export var stun_threshold := 6.0


func _ready():
	$AnimationPlayer.play("enter")


func crumble():
	var debris_instance = debris.instance()
	get_parent().add_child(debris_instance)
	debris_instance.global_transform = $CollisionShape.global_transform
	queue_free()


func _on_area_entered(area):
	if not area.has_method("get_body_speed"):
		return
	
	var incoming_body_speed = area.get_body_speed()
	
	if incoming_body_speed >= speed_threshold:
		crumble()
	
	if not area.has_method("stun_body"):
		return
	
	if incoming_body_speed < speed_threshold and incoming_body_speed >= stun_threshold:
		area.stun_body()
