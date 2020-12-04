extends RichTextLabel

var s = 0 
var m = 0
var h = 0
var pode_iniciar = false

func _ready():
	s = 0
	m = 0
	h = 0

func _process(delta):
	if s > 59 :
		m += 1
		s = 0
	if m > 59 :
		h += 1
		m = 0
	set_text(str(h) + ":" + str(m) + ":" + str(s))


func _on_Timer_timeout():
	if pode_iniciar:
		s += 1
