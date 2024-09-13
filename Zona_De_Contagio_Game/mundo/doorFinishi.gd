extends AnimatableBody2D

var isOpen = false  # Estado da porta (fechada inicialmente)
var playerNearby = false  # Variável para verificar se o jogador está próximo
var player: Node

func _ready():
	# Inicializar o estado da porta
	player = get_node("/root/Node2D/Player")
	
	if isOpen:
		openDoor()
	else:
		closeDoor()

func toggleDoor():
	if isOpen:
		$AnimatedSprite2D.play("Close")
		closeDoor()
	else:
		$AnimatedSprite2D.play("Open")
		openDoor()
#test
func openDoor():
	isOpen = true
	$CollisionShape2D.disabled = true  # Desabilita a colisão ao abrir a porta

func closeDoor():
	isOpen = false
	$CollisionShape2D.disabled = false  # Habilita a colisão ao fechar a porta

func _on_area_2d_body_entered(body: Node2D) -> void:

	if body.name == "Player":  # Verifica se o objeto que entrou é o jogador
		playerNearby = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":  # Verifica se o objeto que saiu é o jogador
		playerNearby = false

func _process(delta):
	if playerNearby and player._score >= 400  and Input.is_action_just_pressed("toggleDoor"):
		toggleDoor()
