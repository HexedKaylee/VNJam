extends Sprite2D

var active = false
var line = ""
var linePrinted = ""
@export var fadeSpd = 3
@export var txtSpd = 20
var stringPos = 0
var txtTimer = 0
@export var stayMax = 90.0
@onready var txt = $RichTextLabel
var vlHolder = ""
var playVL = false

func _ready():
	modulate.a = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!active):
		linePrinted = ""
		stringPos = 0
		txtTimer = 0
		if(snappedf(modulate.a, 0.05) > 0):
			modulate.a = lerp(modulate.a, 0.0, fadeSpd*delta)
		else:
			modulate.a = 0.0
	else:
		if(snappedf(modulate.a, 0.05) < 1):
			modulate.a = lerp(modulate.a, 1.0, fadeSpd*delta)
		else:
			modulate.a = 1.0
			txtTimer += txtSpd*delta
			if(stringPos < line.length()):
				if(txtTimer >= 1.0):
					linePrinted += line[stringPos]
					stringPos += 1
					txtTimer = 0
			if(stringPos >= 2 and playVL):
				if($AudioStreamPlayer.playing):
					$AudioStreamPlayer.stop()
				$AudioStreamPlayer.stream = load("res://Assets/Audio/VO/Prym/Barks/" + vlHolder + ".wav")
				$AudioStreamPlayer.play()
				playVL = false
			else:
				if(txtTimer >= stayMax):
					deactivate()
			
	txt.text = linePrinted
	

func activate(ln, vl):
	active = true
	line = ln
	linePrinted = ""
	stringPos = 0
	txtTimer = 0
	if(vl != ""):
		vlHolder = vl
		playVL = true
	
func deactivate():
	active = false
