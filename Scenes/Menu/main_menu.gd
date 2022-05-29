extends Control

var game_scene = "res://Scenes/Worlds/World.tscn"




func _on_Button_pressed():
	get_tree().change_scene(game_scene)
