extends Node3D
var diminish = false
var scl = 1.0
var shrinkSpeed = 2.0
var playSound = false
var snd = preload("res://Assets/Audio/SFX/sfx_serum.wav")
@export var serum = -1

func _process(delta):
	if(diminish):
		if(!playSound):
			playSound = true
			$AudioStreamPlayer.stream = snd
			$AudioStreamPlayer.play()
		scl = lerp(scl, 0.0, shrinkSpeed*delta)
		scale = Vector3(1.0, 1.0, 1.0)*scl
		if snappedf(scl, 0.005) == 0.0:
			queue_free()
