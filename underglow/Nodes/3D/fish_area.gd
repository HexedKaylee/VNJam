extends Area3D

func _on_body_entered(body):
	if body.name == "Moria":
		body.has_launcher = true
		get_parent().queue_free()
