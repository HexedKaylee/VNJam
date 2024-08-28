extends Node

func _ready():
	var new_dialog = Dialogic.start('grimeline')
	add_child(new_dialog)
