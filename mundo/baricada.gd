extends StaticBody2D

var health: int = 100  # Vida inicial do objeto
var is_passable_by_zombie: bool = false

func _read():
	add_to_group("Barricada")
	$CollisionShape2D.set_disabled(false)

func _on_zombie_hit(damage: int):
	health -= damage
	if health <= 0:
		is_passable_by_zombie = true
		$CollisionShape2D.set_disabled(true)  # Desabilita a colisão
		# (Opcional) Adicionar alguma animação ou efeito ao "morrer"

func _on_body_entered(body: Node):
	if body.is_in_group("Zombie") and is_passable_by_zombie:
		pass  # Permite a passagem do zumbi
	elif body.is_in_group("Player"):
		$CollisionShape2D.set_disabled(false)  # Continua bloqueando o Player
