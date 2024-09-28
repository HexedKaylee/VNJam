extends Button

func _on_pressed():
	var par = get_parent()
	if(!par.transition):
		par.transition = true
		par.transLoad = true
	#Global.loadData()
