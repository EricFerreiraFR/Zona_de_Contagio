extends "res://zombi/zombi_spawn.gd"
var start = false

func _ready() -> void:
	mundo = get_node("/root/Node2D")

func _process(_delta: float) -> void:
	if mundo.level == 4 and start == false:
		start = true
		$Timer.start()

