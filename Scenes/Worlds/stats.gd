extends Node

var win = "res://Scenes/Menu/Win.tscn"

signal tagged

var tagged : int = 0

var start_time : int = 0
var stop_time : int = 0

func reset():
	tagged = 0


func tagged():
	tagged += 1
	emit_signal("tagged")
	
	if tagged >= 5:
		_end_game()


func start_timer():
	start_time = OS.get_unix_time()


func stop_timer():
	stop_time = OS.get_unix_time()


func get_time_in_seconds():
	return stop_time - start_time


func _end_game():
	reset()
	stop_timer()
	get_tree().change_scene(win)
