extends Entity

export(NodePath) var target

onready var _target = get_node(target)


func _ready():
	$Input.target = _target

