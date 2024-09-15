extends AnimatableBody2D

var isOpen = false  	# Estado da porta (fechada inicialmente)
var player: Node 		# Recebe o player 
var zombieSpawn: Node 	# Recebe o Spawn de zombie

func _ready():
	# pega o caminhho do player
	player = get_node("/root/Node2D/Player")

func openDoor():
	isOpen = true
	$AnimatedSprite2D.play("Open")
	$CollisionShape2D.disabled = true  # Desabilita a colisão ao abrir a porta


func _process(delta):
	#abre a porta
	
	if player._score >= 1500 and isOpen == false:
		openDoor()

