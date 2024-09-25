extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_children():
		i.get_node_or_null("CollisionShape3D").queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
