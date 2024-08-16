extends StaticBody2D

var health: int = 100  # Vida inicial do objeto
var is_passable_by_zombie: bool = false

func _init() -> void:
	add_to_group("Barricada")
	
func _ready():
	$cs2d.set("disabled", false)

func _on_zombie_hit(damage: int):
	health -= damage
	print(health)
	if health <= 0:
		is_passable_by_zombie = true
		$cs2d.set("disabled", true)

func _on_body_entered(body: Node):
	if body.is_in_group("Zombie") and is_passable_by_zombie:
		pass
	elif body.is_in_group("Player"):
		$cs2d.set("disabled", false)
	print(body)
