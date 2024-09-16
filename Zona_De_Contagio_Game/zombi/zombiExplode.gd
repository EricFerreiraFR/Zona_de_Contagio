extends "res://zombi/zombi.gd"


@onready var animationPlayer : AnimationPlayer = $AnimationPlayer
@onready var collider2: CollisionShape2D = $Mao/CollisionShape2D
@onready var collider: CollisionShape2D = $CollisionShape2D  # Ajuste o caminho se necessário

func _init() -> void:
	# Adiciona o zombi ao grupo "zombi"
	add_to_group("Zombi")


func _ready() -> void:
	
	animationPlayer.play("walk")


func disable_colliders():
	if collider:
		collider.disabled = true
		collider2.disabled = true
		
func _on_hitPlayer_timeout():
	if _follow != null:
		disable_colliders()
		animationPlayer.stop()
		animationPlayer.play("explode")
		_follow._on_zombie_hit(50)
		_follow = null
		_on_defeated2()

func _on_defeated():
	 # Notificar o player que o inimigo foi derrotado
	$grunido.stop()
	var player = get_parent().get_node("Player")
	player._on_enemy_defeated(70)
	spawnLife()
	queue_free()

	
func _on_defeated2():
	
	await get_tree().create_timer(0.7).timeout
	queue_free()
	
