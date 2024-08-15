extends CharacterBody2D
class_name PlayerShip

const SPEED: float = 200
const TURN_SPEED: float = 5
@onready var _size: Vector2 = $Sprite2D.get_rect().size
@export var _keys: Dictionary = {
	"left":  "ui_left",
	"right": "ui_right",
	"up":    "ui_up", 
	"down":  "ui_down"}

var _input: Vector2 = Vector2.ZERO
var _direction: Vector2 = Vector2.ZERO
var _screen_size: Vector2

func _ready() -> void:
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


func _physics_process(delta):
	# Se a tecla W for pressionada, mova o jogador em direção ao mous
	if Input.is_action_pressed("ui_up"):  # "ui_up" corresponde à tecla W por padrão
		var velocity = _direction * SPEED
		move_and_slide()

func _move_and_turn(delta: float) -> void:
	if Input.is_action_pressed(_keys["left"]):
		rotation -= TURN_SPEED * delta
	elif Input.is_action_pressed(_keys["right"]):
		rotation += TURN_SPEED * delta
	
	# Movimento em direção ao mouse quando a tecla "up" é pressionada
	if Input.is_action_pressed(_keys["up"]):
		# Obter a posição do mouse e a direção do movimento
		var mouse_position = get_global_mouse_position()
		_direction = (mouse_position - global_position).normalized()
		
		# Mover em direção ao mouse
		_input = _direction * SPEED * delta
	else:
		_input = _input.move_toward(Vector2.ZERO, SPEED * delta)

	velocity = _input.limit_length(SPEED)
	move_and_slide()
	_wrap_screen()

func _move_in_any_direction(_delta: float) -> void:
	_input = Input.get_vector(_keys["left"], _keys["right"], _keys["up"], _keys["down"])
	_move_and_rotate(_delta)

func _move_4_directions_nonstop(_delta: float) -> void:
	if Input.is_action_pressed(_keys["left"]):
		_input = Vector2.LEFT
	elif Input.is_action_pressed(_keys["right"]):
		_input = Vector2.RIGHT
	elif Input.is_action_pressed(_keys["up"]):
		_input = Vector2.UP
	elif Input.is_action_pressed(_keys["down"]):
		_input = Vector2.DOWN

	_move_and_rotate(_delta)	

func _move_4_directions(_delta: float) -> void:
	_input = Vector2.ZERO
	
	if Input.is_action_pressed(_keys["left"]):
		_input.x = -1
	elif Input.is_action_pressed(_keys["right"]):
		_input.x = 1
	elif Input.is_action_pressed(_keys["up"]):
		_input.y = -1
	elif Input.is_action_pressed(_keys["down"]):
		_input.y = 1

	_move_and_rotate(_delta)
	
func _move_and_rotate(delta: float) -> void:
	_direction = _direction.slerp(_input, 20.00 * delta)
	rotation = _direction.angle()
	
	velocity = _input * SPEED
	move_and_slide()



func _clamp_screen() -> void:
	position.x = clamp(position.x, _size.x / 2, _screen_size.x - _size.x / 2)
	position.y = clamp(position.y, _size.y / 2, _screen_size.y - _size.y / 2)

func _wrap_screen() -> void:
	position.x = wrap(position.x, 0, _screen_size.x)
	position.y = wrap(position.y, 0, _screen_size.y)
