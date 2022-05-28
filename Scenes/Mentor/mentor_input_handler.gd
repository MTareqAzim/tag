extends InputHandler

export(NodePath) var rays_path
export(NodePath) var state_machine_path
export var safe_distance := 5.0

onready var _rays : Spatial = get_node(rays_path)
onready var _state_machine : StateMachine = get_node(state_machine_path)

var ray_scores : Dictionary
var target : Entity
var final_direction : Vector2 = Vector2.RIGHT


func _physics_process(delta):
	ray_scores = _rays.get_ray_scores()
	_modify_ray_scores()
	_assign_direction()


func _modify_ray_scores():
	var rays_origin = _rays.global_transform.origin
	var target_origin = target.global_transform.origin
	
	var rays_position = Vector2(rays_origin.x, rays_origin.z)
	var target_position = Vector2(target_origin.x, target_origin.z)
	
	var direction_to_target = rays_position.direction_to(target_position)
	var distance_to_target = rays_position.distance_to(target_position)
	
	for direction in ray_scores.keys():
		var direction_factor = clamp(direction_to_target.dot(direction), 0.0, 1.0)
		var distance_factor = 1.0 - clamp(pow(0.5, safe_distance - distance_to_target), 0.0, 1.0)
		var multiplier = 1.0 - (direction_factor * distance_factor)
		
		ray_scores[direction] = ray_scores[direction] * multiplier


func _assign_direction():
	var cumulative_direction := Vector2.ZERO
	
	for direction in ray_scores:
		cumulative_direction += direction * pow(ray_scores[direction], 2)
	
	final_direction = cumulative_direction.normalized()


func print_ray_scores():
	print(final_direction)
	yield(get_tree().create_timer(1.0), "timeout")
	print_ray_scores()


func get_direction() -> Vector2:
	var direction = Vector2(round(final_direction.x), round(final_direction.y))
	return direction


func get_mouse_position() -> Vector3:
	return Vector3(final_direction.x, 0.0, final_direction.y)


func _on_body_entered(body: PhysicsBody):
	if not body.is_in_group("player"):
		return
	
	var dash_event := InputAction.new()
	dash_event.action = "dash"
	dash_event.pressed = true
	
	_state_machine.handle_input(dash_event)


func _on_animation_finished(anim_name):
	print(anim_name)
	_state_machine.on_animation_finished(anim_name)
