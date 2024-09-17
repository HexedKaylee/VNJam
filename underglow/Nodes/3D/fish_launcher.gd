extends Node3D

@export var amplitude = .2
@export var spd = 1.5
var initY = 0.0
var timer = 0.0

func _ready():
	initY = position.y

func _process(delta):
	position.y = amplitude * (sin(timer) - .5) + initY
	timer += delta*spd
