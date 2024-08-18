extends AnimatableBody2D

var is_open = false  # Estado da porta (fechada inicialmente)
var player_nearby = false  # Variável para verificar se o jogador está próximo

func _ready():
	# Inicializar o estado da porta
	if is_open:
		open_door()
	else:
		close_door()

func toggle_door():
	if is_open:
		$AnimatedSprite2D.play("Close")
		close_door()
	else:
		$AnimatedSprite2D.play("Open")
		open_door()

func open_door():
	is_open = true
	$CollisionShape2D.disabled = true  # Desabilita a colisão ao abrir a porta

func close_door():
	is_open = false
	$CollisionShape2D.disabled = false  # Habilita a colisão ao fechar a porta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":  # Verifica se o objeto que entrou é o jogador
		player_nearby = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":  # Verifica se o objeto que saiu é o jogador
		player_nearby = false

func _process(delta):
	if player_nearby and Input.is_action_just_pressed("toggle_door"):
		toggle_door()
