extends RayCast3D

var grabbed = null
@onready var holdPoint = $"../Hold"
var last = Vector3.ZERO

func _process(delta):
	if(Input.is_action_just_pressed("use")):
		if grabbed == null:
			var collider = get_collider()
			if collider != null:
				if collider.name.rstrip("0123456789") == "pickup":
					grabbed = collider
					collider.set_contact_monitor(true)
					collider.set_max_contacts_reported(1)
					collider.set_collision_layer_value(1, false)
					#if("hasGrabbed" in grabbed):
						#grabbed.hasGrabbed = false
					if("startGrab" in grabbed):
						grabbed.startGrab = true
					last = collider.position
		else:
			if(grabbed.get_contact_count() <= 0):
				grabbed.set_collision_layer_value(1, true)
				if("hasGrabbed" in grabbed):
					grabbed.hasGrabbed = true
				grabbed = null
	if grabbed != null:
		grabbed.position = holdPoint.global_position
		grabbed.look_at($"../..".position)
		grabbed.linear_velocity = Vector3.ZERO

		
static func safe_look_at(node: Node3D, target: Vector3) -> void:
	var direction: Vector3 = (target - node.global_transform.origin).normalized()
	
	for up in [Vector3.UP, Vector3.RIGHT, Vector3.BACK]:
		if abs(up.dot(direction)) != 1:
			node.look_at(target, up)
			break
