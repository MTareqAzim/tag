extends Area

export(NodePath) var text_generator

onready var _text_generator = get_node(text_generator)


func _on_area_entered(area):
	if not SlowMotion.slow_motion_active:
		_text_generator.generate_text("TAGGED!", Color.lightgreen)
		SlowMotion.request_slow_motion_change()
		yield(get_tree().create_timer(0.5), "timeout")
		SlowMotion.request_slow_motion_change()
		Stats.tagged()

