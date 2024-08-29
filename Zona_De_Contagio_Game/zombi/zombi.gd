extends CharacterBody2D

@export var _speed: float = 80.0
#@export var _first_follow: NodePath
@export var _followPath: NodePath
var _follow: Node
var _ultimaBarricada: Node

func _init() -> void:
	# Adiciona o zombi ao grupo "zombi"
	add_to_group("Zombi")

func _ready() -> void:
	# Obtém a referência ao jogador usando o NodePath
	if(_followPath):
		_follow = get_node(_followPath)

func _physics_process(delta: float) -> void:
	if _follow:
		var nextPostion: Vector2 = $NavigationAgent2D.get_next_path_position()
		# Calcula a direção até o jogador
		#var direction = ($NavigationAgent2D.get_next_path_position() - global_position).normalized()
		var direction = self.global_position.direction_to(nextPostion)
		#olha para o player
		#look_at($NavigationAgent2D.get_next_path_position())
		look_at((global_position + nextPostion)/2.0)
		
		# Move o zombi na direção do jogador
		velocity = direction * _speed
		move_and_slide()

func _makePath() -> void:
	if(_follow):
		$NavigationAgent2D.set_target_position(_follow.global_position)

func setFollow(newFollow: Node):
	_follow = newFollow
	_makePath()

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
	_follow._on_zombie_hit(10)

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

func _on_timer_navigation_timeout():
	_makePath()
