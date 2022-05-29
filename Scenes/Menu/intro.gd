extends Control

var main_game = "res://Scenes/Worlds/World.tscn"


func _on_pressed():
	get_tree().change_scene(main_game)
