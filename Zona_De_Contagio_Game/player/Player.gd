extends CharacterBody2D
class_name Player

const SPEED: float = 200
@onready var _size: Vector2 = $Sprite2D.get_rect().size
@export var _keys: Dictionary = {
	"left":  "ui_left",
	"right": "ui_right",
	"up":    "ui_up", 
	"down":  "ui_down"}

# Exportar a variável de vida e inicializar os pontos
@export var _health: int = 1000
var _score: int = 0

@export var projetil: PackedScene
var _input: Vector2 = Vector2.ZERO
var _direction: Vector2 = Vector2.ZERO
var _screen_size: Vector2

func _init() -> void:
	add_to_group("Player")

func _ready() -> void:
	update_hud()
	_screen_size = get_viewport_rect().size

func _process(_delta: float) -> void:
	_input = Vector2.ZERO
	# Obtenha a posição do mouse no espaço global
	var mouse_position = get_global_mouse_position()
	# Calcule a direção do jogador para o mouse

	_move_in_any_direction(0.05)
	
	_direction = (mouse_position - global_position).normalized()
	# Rotacione o jogador para apontar para o mouse
	rotation = _direction.angle()
	
	if Input.is_action_just_pressed("MouseClick"):
		_shoot()

func _physics_process(delta):
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
	var bullet = projetil.instantiate()# as Area2D
	owner.add_child(bullet)
	bullet.transform = $Muzzle.global_transform

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

func increase_score(amount: int):
	# Aumentar pontuação
	_score += amount
	update_hud()

func _on_enemy_defeated():
	# Chamado quando um inimigo é derrotado
	increase_score(100)



func _clamp_screen() -> void:
	position.x = clamp(position.x, _size.x / 2, _screen_size.x - _size.x / 2)
	position.y = clamp(position.y, _size.y / 2, _screen_size.y - _size.y / 2)

func _wrap_screen() -> void:
	position.x = wrap(position.x, 0, _screen_size.x)
	position.y = wrap(position.y, 0, _screen_size.y)
