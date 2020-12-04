extends Node2D

var carta = load("res://Cenas/Cartas/Carta.tscn")
<<<<<<< HEAD
var posicao_inicial_carta = [186, -140]
=======
var posicao_inicial_carta = [320, 0]
>>>>>>> b9db3fa24660512ab85b62eb31301a75344b87a1

var cenarios = [[load("res://Cenas/Habitats/Floresta/Floresta.tscn"), "F"],
				[load("res://Cenas/Habitats/NorthPole/NorthPole.tscn"), "N"],
				[load("res://Cenas/Habitats/Rio/Rio.tscn"), "R"],
				[load("res://Cenas/Habitats/Savana/Savana.tscn"), "S"]]

var animais = {
	"F": ["bear", "deer", "racoon", "owl", "rabbit", "squirrel", "skunk", "fox"],
	"N": ["snowy Owl", "polar Bear", "orca", "penguim", "artic Fox", "sea", "walrus", "moose"],
	"R": ["whale", "crab", "octopus", "squid", "sealion", "dolphin", "starfish", "sea Horse"],
	"S": ["cape-Oryx", "hipoppotamus", "giraffe", "lion", "leopard", "zebra", "crocodile", "buffalo"]
}
var animais_do_habitat_baralho = []

# A carta que foi revelada.
var primeira_carta = null
var segunda_carta = null

# As cenas das cartas que foram reveladas.
var cartas_selecionadas = []

# O tempo necessário para esconder a carta pós revelação de uma.
var tempo_decorrido = 0.0
var tempo_limite = 2.0

# Pontuação do jogador.
var pontuacao = 0

# Quantidade de pares que o jogador fez.
var pares = 0
# Animais já virados (pares corretos).
var par_marcado = []

func _ready():
		# Remove o habitat e as cartas caso já exista.
	for _node in get_children():
		if "@Carta" in _node.name or "Carta" in _node.name or "Cenario" in _node.name:
			remove_child(_node)
	
	# Esconde o texto "Parabéns"
<<<<<<< HEAD
	
=======
>>>>>>> b9db3fa24660512ab85b62eb31301a75344b87a1
	$TextoParabens.visible = false
	
	# Escolhe um Habitat/Cenário aleatório.
	randomize()
	var cenario_selecionado = cenarios[randi() % cenarios.size()]
	var cenario_carregado = cenario_selecionado[0].instance()
	
	add_child(cenario_carregado)
	move_child(cenario_carregado, 1)
	
	# Cria a lista com os animais do habitat selecionado e mistura-os.
	animais_do_habitat_baralho = animais[cenario_selecionado[1]] + animais[cenario_selecionado[1]]
	animais_do_habitat_baralho.shuffle()

	# Valores utilizados para ajustar a posição das cartas.
	var multiplicador_x = 0
	var multiplicador_y = 0

	# Adiciona mais 15 cartas ao cenários, totalizando 4x4.
	for i in range(0, 16, 1):
		var _carta = carta.instance()

		# Aumenta Y e reduz X toda vez que 4 cartas forem adicionadas.
		if i % 4 == 0:
			multiplicador_y += 1
			multiplicador_x = 0
		# Aumenta X e mantem Y até 4 cartas serem adicionadas.
		else:
			multiplicador_x += 1

		# Altera a posição da cena "_carta" em "Game.tscn"
		_carta.rect_position.x = posicao_inicial_carta[0] + (multiplicador_x * 120)
		_carta.rect_position.y = posicao_inicial_carta[1] + (multiplicador_y * 120)
		
		# Altera o animal de "_carta".
		_carta.animal = animais_do_habitat_baralho[i]

		add_child(_carta)
<<<<<<< HEAD
	move_child($TextoParabens, 1)
func _physics_process(delta):
	# Gera outro cenário para o jogo após a animação.
	if pares >= 8:
		# Toca uma animação mostrando a palavra "Parabéns!".
		move_child($Pontuacao/TextoPontuacao, 1)
		$TextoParabens.visible = true
=======

func _physics_process(delta):
	# Gera outro cenário para o jogo após a animação.
	if pares >= 1:
		# Toca uma animação mostrando a palavra "Parabéns!".
		move_child($Pontuacao/TextoPontuacao, 1)
		$Pontuacao/TextoPontuacao.visible = true
>>>>>>> b9db3fa24660512ab85b62eb31301a75344b87a1
		
		tempo_decorrido += delta
		
		if tempo_decorrido >= tempo_limite + 2.0:
			_ready()
			pares = 0
			cartas_selecionadas = []
			primeira_carta = null
			segunda_carta = null
			tempo_decorrido = 0
<<<<<<< HEAD
	print(primeira_carta)
	print(segunda_carta)
=======
>>>>>>> b9db3fa24660512ab85b62eb31301a75344b87a1
	
	if primeira_carta != null and segunda_carta != null:
		if primeira_carta == segunda_carta and not par_marcado.has(primeira_carta):
			# Adiciona o animal (do par virado) à lista.
			par_marcado.append(primeira_carta)
			
			# Altera o "NomeAnimal" para o nome do animal (par selecionado).
			$Informacao/NomeAnimal.text = primeira_carta.capitalize()
			
			# Altera o "ImagemAnimal" para a imagem do animal (par selecionado).
<<<<<<< HEAD
			$Informacao/ImagemAnimal.texture = load("res://AnimaisInfo/%s.png" % primeira_carta)
=======
			$Informacao/ImagemAnimal.texture = load("res://Animais/%s.tres" % primeira_carta)
>>>>>>> b9db3fa24660512ab85b62eb31301a75344b87a1
			
			# Deixa as cartas viradas, permite a escolha de outras cartas.
			primeira_carta = null
			segunda_carta = null
			
			# Aumenta a pontuação do jogador.
			pontuacao += 100
			$Pontuacao/Pontuacao.text = str(pontuacao + int($Pontuacao/Pontuacao.text))
			
			cartas_selecionadas = []
			pares += 1
		else:
			# Toca a animação, escodendo a carta, e permite a escolhe de outras.
			tempo_decorrido += delta
			
			if tempo_decorrido >= tempo_limite:
				primeira_carta = null
				segunda_carta = null
			
				for i in cartas_selecionadas:
					i.get_node("AnimationPlayer").play("esconder_carta")
					i.pressionado = false

				cartas_selecionadas = []
				tempo_decorrido = 0
<<<<<<< HEAD


func _on_BotaoSom_pressed():
	$Informacao/AudioStreamPlayer.stream = load("res://animalsSound/%s.wav"%par_marcado[par_marcado.size()-1])
	$Informacao/AudioStreamPlayer.play()


func _on_BotaoPronuncia_pressed():
	$Informacao/AudioStreamPlayer2.stream = load("res://pronunciaSom/%s.wav"%par_marcado[par_marcado.size()-1])
	$Informacao/AudioStreamPlayer2.play()
=======
>>>>>>> b9db3fa24660512ab85b62eb31301a75344b87a1
