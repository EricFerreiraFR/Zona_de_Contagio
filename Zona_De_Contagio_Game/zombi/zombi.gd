extends CharacterBody2D

@export var _speed: float = 100.0
@export var _player_path: NodePath
var _player: Node
var _ultimaBarricada: Node

func _init() -> void:
	# Adiciona o zombi ao grupo "zombi"
	add_to_group("Zombi")

func _ready() -> void:
	# Obtém a referência ao jogador usando o NodePath
	_player = get_node(_player_path)
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
		$Mao/Timer.start(2)

func _on_timer_timeout():
	_ultimaBarricada._on_zombie_hit(10)

func _on_mao_body_exited(body):
	if body.is_in_group("Barricada"):
		$Mao/Timer.stop()
		_ultimaBarricada = null
