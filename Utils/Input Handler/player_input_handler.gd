extends InputHandler
class_name PlayerInputHandler, "input.png"

onready var _body : Entity = get_node(body)
onready var _state_machine : StateMachine = get_node(state_machine)
onready var _action_buffer : ActionBuffer = get_node(action_buffer)
onready var _viewport : Viewport = get_viewport()

export (NodePath) var body
export (NodePath) var state_machine
export (NodePath) var action_buffer

var _map : Array = []
var _input_direction : Vector2 = Vector2()
var _pressed_actions = []


func _ready():
	repopulate_map()

func _unhandled_input(event):
	if event.is_action("move_right") \
	or event.is_action("move_left") \
	or event.is_action("move_forward") \
	or event.is_action("move_back"):
		get_tree().set_input_as_handled()
		_input_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	
	for action_map in _map:
		var mapped_event = action_map.map(event)
		if mapped_event:
			_register_event(mapped_event)
			_state_machine.handle_input(mapped_event)
			get_tree().set_input_as_handled()


func set_input_direction(new_input_direction: Vector2) -> void:
	_input_direction = new_input_direction


func get_mouse_position() -> Vector2:
	var mouse_viewport_position = _viewport.get_mouse_position()
	var camera : Camera = _viewport.get_camera()
	var from = camera.project_ray_origin(mouse_viewport_position)
	var to = camera.project_ray_normal(mouse_viewport_position) * 100
	var mouse_global_position = Plane(Vector3.UP, _body.global_transform.origin.y).intersects_ray(from, to)
	var mouse_body_position = _body.to_local(mouse_global_position)
	
	return mouse_body_position


func add_child(node: Node, legible_unique_name: bool = false) -> void:
	.add_child(node, legible_unique_name)
	repopulate_map()


func remove_child(node: Node) -> void:
	.remove_child(node)
	repopulate_map()


func get_direction() -> Vector2:
	return _input_direction


func is_action_pressed(action: String) -> bool:
	return _pressed_actions.has(action)


func repopulate_map() -> void:
	_map = _populate_map()


func _populate_map() -> Array:
	var map : Array = []
	
	for i in get_child_count():
		var child = get_child(i)
		if child is ActionMap:
			map.append(child)
	
	return map


func _register_event(event: InputAction) -> void:
	if event.is_pressed():
		if not _pressed_actions.has(event.get_action()):
			_pressed_actions.append(event.get_action())
		_action_buffer.add_action(event.get_action() + "_pressed")
	else:
		if _pressed_actions.has(event.get_action()):
			_pressed_actions.erase(event.get_action())
		_action_buffer.add_action(event.get_action() + "_released")


func _on_animation_finished():
	_state_machine.on_animation_finished("finish")
