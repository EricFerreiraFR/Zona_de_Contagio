extends CharacterBody2D

# Variáveis de controle
var move_forward = false
var rotate_right = false
var rotate_left = false

var _markToLive = false

# Velocidade e rotação
var move_speed = 100.0
var rotation_speed = 2.0

# Referências para as linhas (RayCasts)
@onready var raycasts = [
	$RayCast2D1,
	$RayCast2D2,
	$RayCast2D3,
	$RayCast2D4,
	$RayCast2D5
]

var nn: NeuralNetwork

func _init():
	nn = NeuralNetwork.new(5, 5, 3)

func _process(delta):
	_calculate()
	
	# Movimento para frente
	if move_forward:
		velocity = Vector2(cos(rotation), sin(rotation)) * move_speed
		move_and_slide()
	
	# Rotacionar para direita
	if rotate_right:
		rotation += rotation_speed * delta

	# Rotacionar para esquerda
	if rotate_left:
		rotation -= rotation_speed * delta

	move_forward = false
	rotate_right = false
	rotate_left = false
	return


# Função para verificar as distâncias dos RayCasts
func _check_distances():
	var distancias: Array[float] = []
	for ray in raycasts:
		if ray.is_colliding():
			var distance = ray.get_collision_point().distance_to(global_position)
			distancias.append(distance)
		else:
			distancias.append(0.0)
	return distancias

func _calculate():
	var input = _check_distances()
	var result = nn.predict(input)
	move_forward = result[0] > 0.5
	rotate_right = result[1] > 0.5
	rotate_left =  result[2] > 0.5
