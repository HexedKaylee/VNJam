extends Control

var switch = false

func _process(delta):
	if Input.is_action_just_pressed("dialogic_default_action"):
		if !switch:
			switch = true
		else:
			Global.goto_scene("res://Scenes/2D/main_menu.tscn")
	if switch:
		$Credits2.modulate.a += delta
		$CreditsKayleebubble.modulate.a += delta
		$CreditsSkadiLes.modulate.a += delta
