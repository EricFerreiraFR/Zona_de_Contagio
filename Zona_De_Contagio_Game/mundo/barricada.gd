extends StaticBody2D

@export var health: int = 100  # Vida inicial do objeto

func _init() -> void:
	add_to_group("Barricada")

func _ready():
	set_collision_layer_value(6, true)
	set_collision_mask_value(3, true)
	_atualiza_frame()

func _on_zombie_hit(damage: int):
	if health <= 0:
		health = 0
		return
	health -= damage
	_atualiza_frame()
	if health <= 0:
		set_collision_layer_value(6, false)
		set_collision_mask_value(3, false)

func _atualiza_frame():
	if health >= 100:
		$AnimatedSprite2D.play("barricada100")
	elif health >= 75:
		$AnimatedSprite2D.play("barricada75")
	elif health >= 50:
		$AnimatedSprite2D.play("barricada50")
	elif health >= 25:
		$AnimatedSprite2D.play("barricada25")
	elif health >= 0:
		$AnimatedSprite2D.play("barricada0")

func _on_body_entered(body):
	if body.is_in_group("Zombi"):
		#var player = get_parent().find_child("Player",false)
		var player = get_tree().get_nodes_in_group("Player")[0]
		body.set("_player", player)
