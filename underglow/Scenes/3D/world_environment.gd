extends WorldEnvironment
var timer = 0.0
@export var fade_spd = 0.1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_environment().get_sky().get_material().sky_horizon_color.h = ((sin(timer)+1.0)*0.1)+0.6
	timer+=delta*fade_spd
