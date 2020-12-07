extends Node2D
var ultimaCarta = null;
var carta = load("res://Cenas/Cartas/Carta.tscn")
var posicao_inicial_carta = [216, -140]
var infos = {
	"artic Fox": "Animal extremamente branco",
	"bear": "Peludo e sobe em árvores",
	"buffalo": "Chifrudo e forte",
	"cape-Oryx": "Animal com longos chifres",
	"crab": "pequeno, costuma assustar banhistas",
	"crocodile": "feroz e assustador",
	"deer": "magro e com chifres",
	"dolphin": "inteligente e brincalhão",
	"fox": "caça pela noite",
	"giraffe": "pescoço grande",
	"hipoppotamus": "Gordo e com mordida forte",
	"leopard": "Animal extremamente veloz",
	"lion": "Forte, rei do reino animal",
	"moose": "Animal grande e com chifres enormes",
	"octopus": "Solta tinta",
	"orca": "Chamadas de baleias assassinas",
	"owl": "Tem as pernas longas",
	"penguim": "São os machos que cuidam dos ovos",
	"polar Bear": "Podem hibernar",
	"rabbit": "Excelentes reprodutores",
	"racoon": "Ladrãozinho que come lixo",
	"sea Horse": "São os machos que engravidam",
	"sea": "Inteligente e faz um som engraçado",
	"sealion": "Comem bastante e ficam nas pedras",
	"skunk": "Animal fedorento",
	"snowy Owl": "Coruja das neves",
	"squid": "Possui bico de papagaio",
	"squirrel": "Velozes e comem nozes",
	"starfish": "Parecem uma estrela morta porém vivem no fundo do mar",
	"walrus": "Dentes grandes e gostam do gelo",
	"whale": "Conseguem saltar da água",
	"zebra": "São presas de leão e possuem a pele listrada"
	}
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
	Socket.connect("som", self, "onSound")
	Socket.connect("pronuncia", self, "onPronuncia")
	
	
	if $MenuBackground.pode_jogar:
		$Pontuacao/Tempo/Tempo.pode_iniciar = true
		$Pontuacao/Tempo/Timer.start()
		# Remove o habitat e as cartas caso já exista.
		for _node in get_children():
			if "@Carta" in _node.name or "Carta" in _node.name or "Cenario" in _node.name:
				remove_child(_node)
		
		# Esconde o texto "Parabéns"
		
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
		move_child($TextoParabens, 1)
		
func _physics_process(delta):
	#Integração godot/esp
	
	
	
	# Fácil
	if get_node("difMenu").selected_dif == "1":
		get_node("Pontuacao/Tempo/Tempo").mm = 8
		get_node("Pontuacao/Tempo/Tempo").ss = 59
		if get_node("Pontuacao/Tempo/Tempo").m == 9:
			$Timeout.visible = true
			$AnimationPlayer.play("TimeoutAnimation")
			
	# Médio
	if get_node("difMenu").selected_dif == "2":
		get_node("Pontuacao/Tempo/Tempo").mm = 5
		get_node("Pontuacao/Tempo/Tempo").ss = 59
		if get_node("Pontuacao/Tempo/Tempo").m == 6:
			$Timeout.visible = true
			$AnimationPlayer.play("TimeoutAnimation")
			
	# Difícil
	if get_node("difMenu").selected_dif == "3":
		get_node("Pontuacao/Tempo/Tempo").mm = 2
		get_node("Pontuacao/Tempo/Tempo").ss = 59
		if get_node("Pontuacao/Tempo/Tempo").m == 3:
			$Timeout.visible = true
			$AnimationPlayer.play("TimeoutAnimation")
	
	# Gera outro cenário para o jogo após a animação.
	if pares >= 8:
		# Toca uma animação mostrando a palavra "Parabéns!".
		move_child($Pontuacao/TextoPontuacao, 1)
		$TextoParabens.visible = true
		
		$AnimationPlayer.play("CongrAnimation")
		
		tempo_decorrido += delta
		
		if tempo_decorrido >= tempo_limite + 2.0:
			_ready()
			pares = 0
			cartas_selecionadas = []
			primeira_carta = null
			segunda_carta = null
			tempo_decorrido = 0
	
	if primeira_carta != null and segunda_carta != null:
		if primeira_carta == segunda_carta and not par_marcado.has(primeira_carta):
			
			Socket.write_text("acenderGreen\n")
			
			# Adiciona o animal (do par virado) à lista.
			par_marcado.append(primeira_carta)
			
			# Altera o "NomeAnimal" para o nome do animal (par selecionado).
			$Informacao/NomeAnimal.text = primeira_carta.capitalize()
			
			# Altera o Background informação animal para visível.
			$Informacao/InformacaoAnimalBackground.visible = true;
			# Altera o "ImagemAnimal" para a imagem do animal (par selecionado).
			print(primeira_carta)
			var sprite = get_node("Informacao/%s" % primeira_carta)
			get_node("Informacao/DescricaoAnimal").text = infos["%s" % primeira_carta]
			if pares == 0: 
				
				sprite.visible = true
			else:
				sprite.visible = true
				get_node("Informacao/%s" % ultimaCarta).visible = false
			
			ultimaCarta = primeira_carta;
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
				Socket.write_text("acenderRed\n")
				
				for i in cartas_selecionadas:
					i.get_node("AnimationPlayer").play("esconder_carta")
					i.pressionado = false

				cartas_selecionadas = []
				tempo_decorrido = 0


func _on_BotaoSom_pressed():
	$Informacao/AudioStreamPlayer.stream = load("res://animalsSound/%s.wav"%par_marcado[par_marcado.size()-1])
	$Informacao/AudioStreamPlayer.play()


func _on_BotaoPronuncia_pressed():
	$Informacao/AudioStreamPlayer2.stream = load("res://pronunciaSom/%s.wav"%par_marcado[par_marcado.size()-1])
	$Informacao/AudioStreamPlayer2.play()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "TimeoutAnimation":
		# Remove o habitat e as cartas caso já exista.
		for _node in get_children():
			if "@Carta" in _node.name or "Carta" in _node.name or "Cenario" in _node.name:
				remove_child(_node)
		$Pontuacao/Tempo/Tempo.pode_iniciar = false
		$Pontuacao/Tempo/Tempo._ready()
		get_node("MenuBackground")._ready()
		
func onPronuncia():
	$Informacao/AudioStreamPlayer2.stream = load("res://pronunciaSom/%s.wav"%par_marcado[par_marcado.size()-1])
	$Informacao/AudioStreamPlayer2.play()

func onSound():
	$Informacao/AudioStreamPlayer.stream = load("res://animalsSound/%s.wav"%par_marcado[par_marcado.size()-1])
	$Informacao/AudioStreamPlayer.play()
