extends CharacterBody2D

@export var _speed: float = 100.0
@export var _first_follow: NodePath
var _player: Node
var _ultimaBarricada: Node

func _init() -> void:
	# Adiciona o zombi ao grupo "zombi"
	add_to_group("Zombi")

func _ready() -> void:
	# Obtém a referência ao jogador usando o NodePath
	_player = get_node(_first_follow)
	#_player = get_tree().get_root().get_node("res://player/pPlayer.tscn")

func _process(delta: float) -> void:
	if _player:
		# Calcula a direção até o jogador
		var direction = (_player.global_position - global_position).normalized()
		
		#olha para o player
		look_at(_player.position)
		
		# Move o zombi na direção do jogador
		velocity = direction * _speed
		move_and_slide()

func _on_mao_body_entered(body):
	if body.is_in_group("Barricada"):
		_ultimaBarricada = body
		body._on_zombie_hit(10)
		$Mao/HitBarricada.start(2)
	elif body.is_in_group("Player"):
		body._on_zombie_hit(10)
		$Mao/HitPlayer.start(1)

func _on_HitBarricada_timeout():
	if _ultimaBarricada != null:
		_ultimaBarricada._on_zombie_hit(10)

func _on_hitPlayer_timeout():
	_player._on_zombie_hit(10)

func _on_mao_body_exited(body):
	if body.is_in_group("Barricada"):
		$Mao/HitBarricada.stop()
		_ultimaBarricada = null
	elif body.is_in_group("Player"):
		$Mao/HitPlayer.stop()

func _on_defeated():
	 # Notificar o player que o inimigo foi derrotado
	var player = get_parent().get_node("Player")
	player._on_enemy_defeated()
	queue_free()
