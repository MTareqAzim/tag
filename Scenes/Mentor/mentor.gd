extends Entity

export(NodePath) var target
export(NodePath) var arena

onready var _target = get_node(target)
onready var _arena = get_node(arena)


func _ready():
	$Input.target = _target
	$Input.arena = _arena.get_bounds()
	$Input.assign_checkpoint()

