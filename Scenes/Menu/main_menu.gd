extends Control

var intro = "res://Scenes/Menu/Intro.tscn"




func _on_Button_pressed():
	get_tree().change_scene(intro)
