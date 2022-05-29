extends Node

var win = "res://Scenes/Menu/Credits.tscn"

var tagged : int = 0


func reset():
	tagged = 0


func tagged():
	tagged += 1
	
	if tagged >= 5:
		_end_game()


func _end_game():
	reset()
	get_tree().change_scene(win)
