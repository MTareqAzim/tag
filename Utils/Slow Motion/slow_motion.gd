extends Node


var slow_motion_active := false

var normal_time_scale : float = 1.0
var slow_motion_time_scale : float = 0.3

onready var tween : Tween = Tween.new()

func _ready():
	add_child(tween)


func enter_slow_motion_animation():
	tween.stop_all()
	tween.interpolate_property(Engine, "time_scale", Engine.time_scale,
		slow_motion_time_scale, 0.2, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
	yield(tween, "tween_completed")
	start_slow_motion()


func exit_slow_motion_animation():
	tween.stop_all()
	tween.interpolate_property(Engine, "time_scale", Engine.time_scale,
		normal_time_scale, 0.1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
	yield(tween, "tween_completed")
	end_slow_motion()


func start_slow_motion():
	slow_motion_active = true
	Engine.time_scale = slow_motion_time_scale


func end_slow_motion():
	slow_motion_active = false
	Engine.time_scale = normal_time_scale


func request_slow_motion_change():
	if not slow_motion_active:
		enter_slow_motion_animation()
	else:
		exit_slow_motion_animation()
