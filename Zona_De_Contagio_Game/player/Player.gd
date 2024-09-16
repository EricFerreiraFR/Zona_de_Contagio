extends CharacterBody2D
class_name Player

const SPEED: float = 200
#@onready var _size: Vector2 = $Sprite2D.get_rect().size
@export var _keys: Dictionary = {
	"left":  "ui_left",
	"right": "ui_right",
	"up":    "ui_up", 
	"down":  "ui_down"}

# Exportar a variável de vida e inicializar os pontos
@export var _health: int = 1000
var _maxLife: int = _health
var _score: int = 0

@export var projetil: PackedScene
var _input: Vector2 = Vector2.ZERO
var _direction: Vector2 = Vector2.ZERO
var _screen_size: Vector2
var _has_shotgun: bool = false
var _able_to_shoot: bool = true

func _init() -> void:
	add_to_group("Player")

func _ready() -> void:
	update_hud()
	_screen_size = get_viewport_rect().size

func _process(_delta: float) -> void:
	_input = Vector2.ZERO
	# Obtenha a posição do mouse no espaço global
	var mouse_position = get_global_mouse_position()
	
	_move_in_any_direction(0.05)
	
	_direction = (mouse_position - global_position).normalized()
	# Rotacione o jogador para apontar para o mouse
	rotation = _direction.angle()
	
	if Input.is_action_just_pressed("MouseClick"):
		_shoot()

func _physics_process(_delta) -> void:
	pass

func _move_in_any_direction(_delta: float) -> void:
	_input = Input.get_vector(_keys["left"], _keys["right"], _keys["up"], _keys["down"])
	_move_and_rotate(_delta)

func _move_and_rotate(delta: float) -> void:
	_direction = _direction.slerp(_input, 20.00 * delta)
	rotation = _direction.angle()
	
	velocity = _input * SPEED
	move_and_slide()

func _shoot() -> void:
	if(_able_to_shoot == false):
		return
	_able_to_shoot = false
	# Verifica se o player está com a shotgun
	if _has_shotgun:
		$shotgun.play()
		for i in range(3):  # Dispara 3 projéteis
			var bullet = projetil.instantiate()
			owner.add_child(bullet)
			bullet.global_transform = $Muzzle.global_transform
			
			# Calcula um ângulo aleatório entre -15 e 15 graus (convertido para radianos)
			var random_angle = deg_to_rad(randf_range(-15, 15))
			
			# Aplica a rotação ao projétil
			bullet.rotation += random_angle
			
			# Define a direção do projétil com base no ângulo
			var direction = (_direction.rotated(random_angle)).normalized()
		await get_tree().create_timer(0.5).timeout
	else:
		$pistol.play()
		# Comportamento padrão para arma normal
		var bullet = projetil.instantiate()
		owner.add_child(bullet)
		bullet.global_transform = $Muzzle.global_transform
		await get_tree().create_timer(0.3).timeout
	_able_to_shoot = true

func _on_zombie_hit(amount: int):
	#print(_health)
	decrease_health(amount)

func update_hud():
	# Atualizar os labels no HUD
	#get_node(_score_label).text = "Score: %d" % _score
	get_parent().update_score(_score)
	#get_node(_health_label).text = "Health: %d" % _health
	get_parent().update_health(_health)

func decrease_health(amount: int):
	# Diminuir vida
	_health -= amount
	if _health <= 0:
		get_parent().GameOver()
	update_hud()

func increase_health(amount: int):
	if(amount <= 0):
		return
	if(_health >= _maxLife):
		return
	# Diminuir vida
	_health += amount
	update_hud()

func increase_score(amount: int):
	# Aumentar pontuação
	_score += amount
	update_hud()

func _on_enemy_defeated():
	# Chamado quando um inimigo é derrotado
	increase_score(100)
