extends Sprite2D
var timer = 0.3
@export var amplitude = 0.5
@export var fade_spd = 1.4

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	modulate.a = (sin(timer)+3)*amplitude/2.0
	timer+=delta*fade_spd
