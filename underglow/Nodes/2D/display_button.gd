extends Button

var baseText = "fullscreen: "

func _on_pressed():
	var fullscreen = DisplayServer.window_get_mode()
	if(fullscreen != DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		text = baseText + "on"
		DisplayServer.window_set_size(Vector2i(1920, 1080))
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		text = baseText + "off"
		DisplayServer.window_set_size(Vector2i(1280, 720))

func _process(delta):
	var fullscreen = DisplayServer.window_get_mode()
	if(fullscreen != DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN):
		text = baseText + "off"
	else:
		text = baseText + "on"
	
