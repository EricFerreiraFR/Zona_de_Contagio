extends AnimatableBody2D

var isOpen = false  	# Estado da porta (fechada inicialmente)
var player: Node 		# Recebe o player 
var zombieSpawn: Node 	# Recebe o Spawn de zombie

func _ready():
	# pega o caminhho do player
	player = get_node("/root/Node2D/Player")
	zombieSpawn = get_node("/root/Node2D/ZombiSpaw")

func openDoor():
	isOpen = true
	$AnimatedSprite2D.play("Open")
	$CollisionShape2D.disabled = true  # Desabilita a colisão ao abrir a porta


func _process(delta):
	#ativa o nivel dois
	if player._score >= 1800 and isOpen == false:
		zombieSpawn.level = 2
		openDoor()
	if player._score >= 2800:
		zombieSpawn.level = 3
		print(zombieSpawn.level)
