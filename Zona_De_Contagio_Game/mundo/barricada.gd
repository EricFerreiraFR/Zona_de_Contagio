extends StaticBody2D

@export var health: int = 100  # Vida inicial da barricada
@export var heal_amount: int = 10  # Quantidade de cura por clique
@export var heal_speed: float = 0.2  # Intervalo entre curas

var is_player_near = false
var is_healing = false

func _init() -> void:
	add_to_group("Barricada")

func _ready():
	# Define o valor inicial da barra de progresso e esconde o texto
	$Control/ProgressBar.value = health
	$Control/Label.text = ""

func _process(_delta: float):
	# Verifica se o player está perto e se o botão direito do mouse foi pressionado
	if is_player_near and Input.is_action_pressed("RightMouseClick") and not is_healing:
		is_healing = true 
		heal_barricade()

# Função para curar a barricada ao clicar com o botão direito
func heal_barricade():
	if health < 100:
		health += heal_amount
		health = min(health, 100)  # Limita a vida máxima a 100
		$Control/ProgressBar.value = health
		_atualiza_frame()
		await get_tree().create_timer(heal_speed).timeout  # Aguarda o tempo de cura
		#cura
		$Control/ProgressBar.value = clamp(health, 0, 100)
		_atualiza_frame()
		if health >= 0:
			set_collision_layer_value(7, true)
	is_healing = false

# Função chamada quando o player entra na área
func _on_body_entered(body: Node):
	if body.is_in_group("Zombi"):
		var player = get_tree().get_nodes_in_group("Player")[0]
		body.setFollow(player)

# Função chamada quando a barricada é atingida por zumbis
func _on_zombie_hit(damage: int):
	if health <= 0:
		health = 0
		return
	health -= damage
	$Control/ProgressBar.value = clamp(health, 0, 100)
	_atualiza_frame()
	if health <= 0:
		set_collision_layer_value(7, false)

func _on_player_near_body_entered(body):
	if body.is_in_group("Player"):
		is_player_near = true
		$Control/Label.text = "Pressione o botão direito para curar"

func _on_player_near_body_exited(body):
	if body.is_in_group("Player"):
		is_player_near = false
		$Control/Label.text = ""  # Esconde o texto quando o player se afasta

# Atualiza a animação da barricada com base na vida atual
func _atualiza_frame():
	if health >= 100:
		$AnimatedSprite2D.play("barricada100")
		$AnimatedSprite2D2.play("barricada100")
	elif health >= 75:
		$AnimatedSprite2D.play("barricada75")
		$AnimatedSprite2D2.play("barricada75")
	elif health >= 50:
		$AnimatedSprite2D.play("barricada50")
		$AnimatedSprite2D2.play("barricada50")
	elif health >= 25:
		$AnimatedSprite2D.play("barricada25")
		$AnimatedSprite2D2.play("barricada25")
	else:
		$AnimatedSprite2D.play("barricada0")
		$AnimatedSprite2D2.play("barricada0")
