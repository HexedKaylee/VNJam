extends Control

var switch = false
var leave = false

func _process(delta):
	if Input.is_action_just_pressed("dialogic_default_action"):
		if !switch:
			switch = true
		else:
			leave = true
	if switch:
		$Credits2.modulate.a += delta
		$CreditsKayleebubble.modulate.a += delta
		$CreditsSkadiLes.modulate.a += delta
	if leave:
		$ColorRect.color.a = lerp($ColorRect.color.a, 1.0, 8*delta)
		if(snappedf($ColorRect.color.a, 0.0005) == 1.0):
			Global.musicLoc = $AudioStreamPlayer.get_playback_position()
			Global.goto_scene("res://Scenes/2D/main_menu.tscn")
