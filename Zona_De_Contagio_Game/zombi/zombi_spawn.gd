extends Node2D

@export var zombi_scene: PackedScene
@export var spawn_interval: float = 2.0
@export var spawn_area_size: Vector2 = Vector2(200, 200)
@export var _first_follow: NodePath
@export var ChanceDeSpawn: float = 0.3

var _timer: Timer
var level : int = 1


func _ready() -> void:
	$Timer.start()

func _on_timer_timeout():
	var vNrRand = randi() % 100
	if((100*ChanceDeSpawn) < vNrRand):
		return
	
	# Instancia o zombi
	var zombi = zombi_scene.instantiate() as CharacterBody2D
	
	# Define a posição do spawn aleatoriamente dentro da área de spawn
	zombi.position = position

	# Configura o caminho do jogador para o zumbi
	zombi.setFollow(get_node(_first_follow))

	# Adiciona o zumbi à cena
	get_parent().add_child(zombi)


#var spawn_position = Vector2(
#	randf_range(-spawn_area_size.x / 2, spawn_area_size.x / 2),
#	randf_range(-spawn_area_size.y / 2, spawn_area_size.y / 2)
#)
