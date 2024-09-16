extends "res://zombi/zombi.gd"


@onready var animationTree : AnimationPlayer = $AnimationPlayer

func _init() -> void:
	# Adiciona o zombi ao grupo "zombi"
	add_to_group("Zombi")


func _ready() -> void:
	
	animationTree.play("walk")

func _on_hitPlayer_timeout():
	animationTree.stop()
	animationTree.play("explode")
	_follow._on_zombie_hit(50)
	_on_defeated2()

func _on_defeated2():
	queue_free()
