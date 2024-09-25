extends Node2D

@export var _personagem: PackedScene
var qtdPorGeracao = 10
var numero_melhores_pais = 10 # Quantidade de melhores pais que serão passados diretamente para a próxima geração
var numero_filhos_por_pais = 90 # Quantidade de filhos gerados pelos melhores pais (90 + 10 melhores = 100)

var _geracao: Array[CharacterBody2D] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	create_generation(qtdPorGeracao)

func _process(delta):
	pass

# Cria uma nova geração de personagens
func create_generation(qtd: int):
	_geracao.clear()
	
	var persona
	for i in range(qtd):
		persona = _personagem.instantiate() as CharacterBody2D
		_geracao.append(persona)
		self.add_child(persona)

# Função chamada ao final de cada geração para determinar quem irá continuar
func evolve_generation():
	# Ordena os personagens pelo seu desempenho (pontuação)
	_geracao.sort_custom(Callable(self, "sort_by_score"))

	# Seleciona os melhores pais que irão diretamente para a próxima geração
	var melhores_pais = _geracao.slice(0, numero_melhores_pais)
	
	# Marca os melhores pais para não serem deletados
	for pai in melhores_pais:
		pai._markToLive = true

	# Gera filhos a partir dos melhores pais
	var nova_geracao: Array[CharacterBody2D] = []
	for i in range(numero_filhos_por_pais):
		var pai1 = melhores_pais[randi() % numero_melhores_pais].get_neural_network()
		var pai2 = melhores_pais[randi() % numero_melhores_pais].get_neural_network()
		
		# Reproduz os pais para criar um novo filho
		var novo_filho_nn = NeuralNetwork.reproduce(pai1, pai2)
		# Aplica mutações no filho
		#novo_filho_nn = NeuralNetwork.mutate(novo_filho_nn, self._mutation_callback)

		# Instancia um novo personagem com a rede neural gerada
		var novo_filho = _personagem.instantiate() as CharacterBody2D
		novo_filho.set_neural_network(novo_filho_nn)
		nova_geracao.append(novo_filho)

	# Adiciona os melhores pais à nova geração
	for pai in melhores_pais:
		nova_geracao.append(pai)

	# Substitui a geração antiga pela nova
	for personagem in _geracao:
		if not personagem._markToLive:
			personagem.queue_free()

	_geracao = nova_geracao
	for novo_personagem in _geracao:
		if not novo_personagem.get_parent():
			self.add_child(novo_personagem)

# Função para ordenar os personagens por pontuação
func sort_by_score(a: CharacterBody2D, b: CharacterBody2D) -> int:
	var pontos_a = calculate_score(a)
	var pontos_b = calculate_score(b)
	return pontos_b - pontos_a  # Ordena em ordem decrescente

# Função para calcular a pontuação de cada personagem
func calculate_score(personagem: CharacterBody2D) -> int:
	# Defina a lógica para calcular os pontos do personagem aqui
	# Por exemplo, pode ser a distância percorrida, tempo sobrevivido, etc.
	return personagem.get_points()

# Função chamada para realizar mutações (pode ser personalizada)
func _mutation_callback(nn: NeuralNetwork):
	# Aplique mutações específicas na rede neural do personagem
	pass

# Chamada a cada intervalo de tempo para evoluir a geração
func _on_timer_timeout():
	#evolve_generation()
	return




#==========================================================================
func updateLevel(level: int):
	pass
	
func updateRound(Round: int):
	pass

func update_score(score: int):
	pass

func update_health(health: int):
	pass
