extends CharacterBody2D

@export var _speed: float = 100.0
@export var _player_path: NodePath
var _player: Node

func _ready() -> void:
	# Adiciona o zombi ao grupo "zombi"
	add_to_group("Zombi")
	
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
