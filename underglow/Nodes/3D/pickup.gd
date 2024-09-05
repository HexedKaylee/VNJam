extends RigidBody3D

@export var player = Node3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global_transform.origin.distance_to(player.global_transform.origin) > 5:
		freeze = true
	else:
		freeze = false
