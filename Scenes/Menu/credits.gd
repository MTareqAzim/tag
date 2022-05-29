extends Control

var main_menu = "res://Scenes/Menu/MainMenu.tscn"


func _on_Restart_pressed():
	get_tree().change_scene(main_menu)
