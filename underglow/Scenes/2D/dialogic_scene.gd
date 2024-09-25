extends Control

func _ready():
	Dialogic.start(Global.get_timeline())
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_dialogic_signal(argument:String):
	match argument:
		"start_experiment_1":
			Global.goto_scene("res://Scenes/3D/experiment_1.tscn")
		"start_experiment_2":
			Global.goto_scene("res://Scenes/3D/experiment_2.tscn")
		"start_experiment_3":
			Global.goto_scene("res://Scenes/3D/experiment_3.tscn")
		"start_experiment_4":
			Global.goto_scene("res://Scenes/3D/experiment_4.tscn")
		_:
			print("Invalid signal!")
