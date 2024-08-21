extends Area2D

@export var speed: float = 400.0
@export var lifetime: float = 5.0

var _speed = 750

func _init() -> void:
	add_to_group("Bullet")

func _ready() -> void:
	var timer : Timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.autostart = false
	timer.wait_time = 5.0
	timer.timeout.connect(_time_out)
	timer.start()

func _physics_process(delta):
	position += transform.x * _speed * delta

func _time_out():
	queue_free()

func _on_body_entered(body):
	if body.is_in_group("Zombi"):
		body._on_defeated()
		queue_free()
	elif body.is_in_group("Barricada"):
		return
	else:
		queue_free()
