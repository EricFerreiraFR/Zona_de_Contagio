extends Node2D

@export var zombi_scene: PackedScene
@export var spawn_interval: float = 2.0
@export var spawn_area_size: Vector2 = Vector2(200, 200)
@export var player_path: NodePath

var _timer: Timer

func _ready() -> void:
	$Timer.start()

func _on_timer_timeout():
	# Instancia o zombi
	var zombi = zombi_scene.instantiate() as CharacterBody2D
	
	# Define a posição do spawn aleatoriamente dentro da área de spawn
	zombi.position = position
	
	# Configura o caminho do jogador para o zumbi
	zombi.set("_player_path", player_path)

	# Adiciona o zumbi à cena
	get_parent().add_child(zombi)


#var spawn_position = Vector2(
#	randf_range(-spawn_area_size.x / 2, spawn_area_size.x / 2),
#	randf_range(-spawn_area_size.y / 2, spawn_area_size.y / 2)
#)
