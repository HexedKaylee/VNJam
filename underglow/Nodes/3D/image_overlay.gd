extends Sprite2D

var active = false
var timer = 0.0
var maxHorror = .1
var waveSpeed = 1.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(active):
		timer += delta*waveSpeed
		modulate.a = sin(timer)*maxHorror
