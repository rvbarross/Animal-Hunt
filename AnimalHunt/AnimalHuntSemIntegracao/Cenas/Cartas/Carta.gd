extends Button

# O animal que a carta está segurando.
var animal = ""
var pressionado = false

func _on_Carta_pressed():
	if !pressionado:
		pressionado = true
	
		# Adiciona a carta às cartas selecionadas.
		get_parent().cartas_selecionadas.append(self)
		
		# Verifica a carta e atribui valor.
		if get_parent().primeira_carta == null:
			get_parent().primeira_carta = animal
		elif get_parent().segunda_carta == null:
			get_parent().segunda_carta = animal
		
		$AnimationPlayer.play("revelar_carta")
		$animal.texture = load("res://Animais/%s.tres" % animal)
