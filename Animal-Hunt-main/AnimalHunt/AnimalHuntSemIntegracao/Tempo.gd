extends RichTextLabel
var mm = 0
var ss = 0
var s = 0 
var m = 0
#var h = 0
var pode_iniciar = false

func _ready():
	var mm = 0
	var ss = 0
	s = 0
	m = 0
	#h = 0

func _process(delta):
	if s > 59 :
		m += 1
		s = 0
	if m > 59 :
		#h += 1
		m = 0
	set_text(str(mm - m) + ":" + str(ss - s))


func _on_Timer_timeout():
	if pode_iniciar:
		s += 1
