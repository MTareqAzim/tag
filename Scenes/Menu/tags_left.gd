extends Control

var heads : Array = []

func _ready():
	Stats.connect("tagged", self, "remove_a_tag")
	for child in $HBoxContainer.get_children():
		heads.append(child)


func remove_a_tag():
	var head = heads.pop_front()
	head.queue_free()
