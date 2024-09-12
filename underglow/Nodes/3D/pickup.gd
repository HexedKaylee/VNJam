extends RigidBody3D

@export var player = Node3D

func _process(delta):
	freezer()

func freezer():
	if global_transform.origin.distance_to(player.global_transform.origin) > 17:
		freeze = true
	else:
		freeze = false
