extends Area2D

@export var speed: float = 400.0
@export var lifetime: float = 5.0

var _speed = 750
var _time: int = Time.get_ticks_msec()

func _ready() -> void:
	add_to_group("Bullet")

func _physics_process(delta):
	position += transform.x * _speed * delta
	if(Time.get_ticks_msec() - _time > lifetime * 1000):
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("Zombi"):
		body.queue_free()
	queue_free()
	pass # Replace with function body.
