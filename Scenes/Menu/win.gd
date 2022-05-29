extends Control

var credits = "res://Scenes/Menu/Credits.tscn"


func _ready():
	var time : int = Stats.get_time_in_seconds()
	var minutes : int = time / 60
	var seconds : int = time % 60
	
	var text = "Your time was %d minutes\nand %d seconds!" % [minutes, seconds]
	
	$VBoxContainer/Time/Label.text = text


func _on_pressed():
	get_tree().change_scene(credits)
