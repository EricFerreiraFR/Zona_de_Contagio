extends Node2D

@export var qtdRecupera: int = 100

# Parâmetros para inclinação e movimento vertical
var angle_limit = 15.0  # Ângulo máximo de inclinação (em graus)
var angle_speed = 4.0   # Velocidade de inclinação
var vertical_amplitude = 4.0  # Amplitude do movimento vertical
var vertical_speed = 2.0       # Velocidade do movimento vertical

# Variáveis internas
var angle_direction = 1  # Direção da inclinação (-1 ou 1)
var current_angle = 0.0  # Ângulo atual
var initial_position = Vector2()  # Posição inicial do item
var time_passed = 0.0  # Acumulador de tempo para o movimento vertical

var animate: bool = true
var _player: Node2D  # Posição do player

func _ready():
	# Armazena a posição inicial para o movimento vertical
	initial_position = position
	
func _process(delta):
	# Movimento de inclinação (balançar de um lado para o outro)
	current_angle += angle_direction * angle_speed * delta
	rotation_degrees = current_angle
	
	# Muda a direção da inclinação ao atingir os limites
	if abs(current_angle) >= angle_limit:
		angle_direction *= -1  # Inverte a direção da inclinação
	
	if animate:
		time_passed += delta
		position.y = initial_position.y + sin(time_passed * vertical_speed) * vertical_amplitude


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		body._has_shotgun = true
		queue_free()
