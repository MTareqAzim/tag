extends Node

var win = "res://Scenes/Menu/Credits.tscn"

signal tagged

var tagged : int = 0


func reset():
	tagged = 0


func tagged():
	tagged += 1
	emit_signal("tagged")
	
	if tagged >= 5:
		_end_game()


func _end_game():
	reset()
	get_tree().change_scene(win)
