extends Node2D

@export var zombiNormal: PackedScene
@export var speedZombi: PackedScene
@export var tankZombi: PackedScene
@export var explodeZombi: PackedScene
@export var spawn_interval: float = 2.0
@export var spawn_area_size: Vector2 = Vector2(200, 200)
@export var _first_follow: NodePath
@export var ChanceDeSpawn: float = 0.5

var mundo : Node
var zumbisSpawnados: int = 0

func _ready() -> void:
	mundo = get_node("/root/Node2D")
	$Timer.start()

func _on_timer_timeout():
	
	var vNrRand = randi() % 100
	

	if mundo.quantiaZumbis >= zumbisSpawnados and mundo.waitRound == false:
		if((100*ChanceDeSpawn) < vNrRand):
			return
		
		# Instancia o zombi
		var zombi = zombiNormal.instantiate() as CharacterBody2D
		
		# Define a posição do spawn aleatoriamente dentro da área de spawn
		zombi.position = position

		# Configura o caminho do jogador para o zumbi
		zombi.setFollow(get_node(_first_follow))

		# Adiciona o zumbi à cena
		zumbisSpawnados += 1 # conta a quantidade de zumbis gerado
		get_parent().add_child(zombi)
			
		var zombiEx = explodeZombi.instantiate() as CharacterBody2D
		
		# Define a posição do spawn aleatoriamente dentro da área de spawn
		zombiEx.position = position

		# Configura o caminho do jogador para o zumbi
		zombiEx.setFollow(get_node(_first_follow))

		# Adiciona o zumbi à cena
		zumbisSpawnados += 1 # conta a quantidade de zumbis gerado
		get_parent().add_child(zombiEx)
		
		
		if mundo.level == 2 and zumbisSpawnados%2 == 0:
			var speedZombie = speedZombi.instantiate() as CharacterBody2D
					# Define a posição do spawn aleatoriamente dentro da área de spawn
			speedZombie.position = position

			# Configura o caminho do jogador para o zumbi
			speedZombie.setFollow(get_node(_first_follow))

			# Adiciona o zumbi à cena
			zumbisSpawnados += 1 # conta a quantidade de zumbis gerado
			get_parent().add_child(speedZombie)
			
	elif mundo.waitRound and zumbisSpawnados > 0:
		zumbisSpawnados = 0	

#var spawn_position = Vector2(
#	randf_range(-spawn_area_size.x / 2, spawn_area_size.x / 2),
#	randf_range(-spawn_area_size.y / 2, spawn_area_size.y / 2)
#)
