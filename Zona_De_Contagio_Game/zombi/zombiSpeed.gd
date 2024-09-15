extends "res://zombi/zombi.gd"

func _init() -> void:
	_maxhealth = 100 / 2
	_speed = _speed * 0.6
	# Adiciona o zombi ao grupo "zombi"
	add_to_group("Zombi")
