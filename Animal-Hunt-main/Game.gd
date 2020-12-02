extends Node2D

var carta = load("res://Cenas/Cartas/Carta.tscn")
var posicao_inicial_carta = [320, 0]

var cenarios = [[load("res://Cenas/Habitats/Floresta/Floresta.tscn"), "F"],
				[load("res://Cenas/Habitats/NorthPole/NorthPole.tscn"), "N"],
				[load("res://Cenas/Habitats/Rio/Rio.tscn"), "R"],
				[load("res://Cenas/Habitats/Savana/Savana.tscn"), "S"]]

var animais = {
	"F": ["bear", "deer", "racoon", "owl", "rabbit", "squirrel", "skunk", "fox"],
	"N": ["owlNorth", "bearPole", "WhaleKiller", "Penguim", "foxNorth", "sea", "walrus", "moose"],
	"R": ["whale", "crab", "octopus", "squid", "sealion", "dolphin", "patrick", "seaHorse"],
	"S": ["capeOryx", "hipoppotamus", "giraffe", "lion", "leopard", "zebra", "crocodile", "buffalo"]
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

func _ready():
	# Escolhe um Habitat/Cenário aleatório.
	$"menu".play("menu")
	$"LedSolo".play()
	

func _physics_process(delta):
	if primeira_carta != null and segunda_carta != null:
		if primeira_carta == segunda_carta:
			print("FOI")
		else:
			tempo_decorrido += delta
			
			if tempo_decorrido >= tempo_limite:
				primeira_carta = null
				segunda_carta = null
			
				for i in cartas_selecionadas:
					i.get_node("AnimationPlayer").play("esconder_carta")
					i.pressionado = false

				cartas_selecionadas = []
				tempo_decorrido = 0


func _on_menu_animation_finished():
	$"btnPlay".visible = true
	$"btnExit".visible = true


func _on_btnPlay_pressed():
	randomize()
	var cenario_selecionado = cenarios[randi() % cenarios.size()]
	add_child(cenario_selecionado[0].instance())

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
