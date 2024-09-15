extends AnimatableBody2D

var isOpen = false  # Estado da porta (fechada inicialmente)
var playerNearby = false  # Variável para verificar se o jogador está próximo
var player: Node

func _ready():
	# Inicializar o estado da porta
	player = get_node("/root/Node2D/Player")

func toggleDoor():
	
	$AnimatedSprite2D.play("Open")
	openDoor()
	# Tela de final

func openDoor():
	isOpen = true
	$CollisionShape2D.disabled = true  # Desabilita a colisão ao abrir a porta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":  # Verifica se o objeto que entrou é o jogador
		playerNearby = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":  # Verifica se o objeto que saiu é o jogador
		playerNearby = false

func _process(delta):
	if playerNearby and player._score >= 15000  and Input.is_action_just_pressed("toggleDoor") and isOpen == false:
		toggleDoor()
