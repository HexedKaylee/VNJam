extends Sprite2D

@export var spinSpeed = .2

func _process(delta):
	global_rotation += spinSpeed*delta
