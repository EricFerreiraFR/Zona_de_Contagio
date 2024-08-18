extends StaticBody2D

var health: int = 10  # Vida inicial do objeto

func _init() -> void:
	add_to_group("Barricada")
	
func _ready():
	pass

func _on_zombie_hit(damage: int):
	health -= damage
	print(health)
	if health <= 0:
		set_collision_layer_value(6, false)
		set_collision_mask_value(3, false)
