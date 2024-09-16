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

#var _player: Node2D  # Posição do player

func _ready():
	# Armazena a posição inicial para o movimento vertical
	initial_position = position
	

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		body._has_shotgun = true
		queue_free()
