extends InputHandler

export(NodePath) var rays_path
export(NodePath) var state_machine_path
export(NodePath) var dash_area_path
export var safe_distance := 5.0
export var dash_cooldown := 3.0
export var target_dash_threshold := 6.0
export var checkpoint_reached_distance := 2.0

onready var _rays : Spatial = get_node(rays_path)
onready var _state_machine : StateMachine = get_node(state_machine_path)
onready var _dash_area : Area = get_node(dash_area_path)

var ray_scores : Dictionary
var target : Entity
var arena : Rect2
var checkpoint : Vector2
var final_direction : Vector2 = Vector2.RIGHT
var can_dash : bool = true
var target_dashing : bool = false
var perpendicular_direction : Vector2 = Vector2.ZERO


func _physics_process(delta):
	ray_scores = _rays.get_ray_scores()
	_reach_checkpoint()
	_target_dashing()
	_modify_ray_scores()
	_assign_direction()


func _reach_checkpoint():
	var rays_origin = _rays.global_transform.origin
	var rays_position = Vector2(rays_origin.x, rays_origin.z)
	var distance_to_checkpoint = rays_position.distance_to(checkpoint)
	
	if distance_to_checkpoint <= checkpoint_reached_distance:
		assign_checkpoint()


func _target_dashing():
	var target_velocity = target.get_velocity_2d()
	var target_is_dashing = target_velocity.length() >= target_dash_threshold
	
	if not target_dashing:
		if target_is_dashing:
			var rays_origin = _rays.global_transform.origin
			var target_origin = target.global_transform.origin
			
			var rays_position = Vector2(rays_origin.x, rays_origin.z)
			var target_position = Vector2(target_origin.x, target_origin.z)
			
			var closest_point = Geometry.get_closest_point_to_segment_uncapped_2d(
				rays_position, target_position, target_position + target_velocity)
			
			target_dashing = true
			perpendicular_direction = (rays_position - closest_point).normalized()
	else:
		if not target_is_dashing:
			target_dashing = false
			perpendicular_direction = Vector2.ZERO


func _modify_ray_scores():
	var rays_origin = _rays.global_transform.origin
	var target_origin = target.global_transform.origin
	
	var rays_position = Vector2(rays_origin.x, rays_origin.z)
	var target_position = Vector2(target_origin.x, target_origin.z)
	
	var direction_to_target = rays_position.direction_to(target_position)
	var distance_to_target = rays_position.distance_to(target_position)
	
	var direction_to_checkpoint = rays_position.direction_to(checkpoint)
	
	for direction in ray_scores.keys():
		var direction_factor = clamp(direction_to_target.dot(direction), 0.1, 1.0)
		var distance_factor = 1.0 - clamp(pow(0.5, safe_distance - distance_to_target), 0.0, 1.0)
		var multiplier = 1.0 - (direction_factor * distance_factor)
		
		var checkpoint_multiplier = clamp(direction_to_checkpoint.dot(direction), 0.1, 1.0)
		
		var original_score = ray_scores[direction]
		var multiplied_score = original_score * multiplier 
		var checkpoint_score = original_score * checkpoint_multiplier
		var scaled_score = (multiplied_score + checkpoint_score) / (2 * original_score)
		
		if target_dashing and distance_to_target < safe_distance:
			var side_step_multiplier = clamp(perpendicular_direction.dot(direction), 0.1, 1.0)
			var side_step_score = original_score * side_step_multiplier
			scaled_score = multiplied_score + side_step_score
		
		ray_scores[direction] = scaled_score


func _assign_direction():
	var cumulative_direction := Vector2.ZERO
	
	for direction in ray_scores:
		cumulative_direction += direction * ray_scores[direction]
	
	final_direction = cumulative_direction.normalized()


func get_direction() -> Vector2:
	return final_direction


func get_mouse_position() -> Vector3:
	return Vector3(final_direction.x, 0.0, final_direction.y)


func assign_checkpoint():
	var random_x = randf()
	var random_y = randf()
	
	var local_position = Vector2(arena.size.x * random_x, arena.size.y * random_y)
	checkpoint = arena.position + local_position


func _try_to_dash(body: PhysicsBody):
	if not body.is_in_group("player"):
		return
	
	if not can_dash:
		return
	
	_lock_dash()
	
	var dash_event := InputAction.new()
	dash_event.action = "dash"
	dash_event.pressed = true
	
	_state_machine.handle_input(dash_event)


func _lock_dash():
	can_dash = false
	yield(get_tree().create_timer(dash_cooldown), "timeout")
	can_dash = true
	
	for body in _dash_area.get_overlapping_bodies():
		_try_to_dash(body)


func _on_body_entered(body: PhysicsBody):
	_try_to_dash(body)


func _on_animation_finished(anim_name):
	_state_machine.on_animation_finished(anim_name)
