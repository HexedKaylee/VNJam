extends Sprite2D

var active = false
var timer = 0.0
var maxHorror = .1
var waveSpeed = 1.5
@export var top = false
var startY = 0.0

func _ready():
	startY = position.y
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(active):
		timer += delta*waveSpeed
		modulate.a = sin(timer)*maxHorror
		if(top):
			position.y = startY + sin(timer/1.5)*50.0
		else:
			position.y = startY - sin(timer/1.5)*50.0
			
			
		
