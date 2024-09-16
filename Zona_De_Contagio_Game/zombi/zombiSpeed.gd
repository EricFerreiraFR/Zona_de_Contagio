extends "res://zombi/zombi.gd"

func _init() -> void:
	_maxhealth = 100 / 2
	_speed = _speed * 1.5
	# Adiciona o zombi ao grupo "zombi"
	add_to_group("Zombi")

func _on_defeated():
	 # Notificar o player que o inimigo foi derrotado
	$grunido.stop()
	var player = get_parent().get_node("Player")
	player._on_enemy_defeated(25)
	spawnLife()
	queue_free()
