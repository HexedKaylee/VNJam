extends RigidBody3D

@export var accel = 250.0
@export var topSpeed = 200.0
@export var timeOut = 15.0
@onready var player = Node3D

func _ready():
	$"Fish/Armature-fish/Skeleton3D/Fish_001".get_active_material(0).set_shader_parameter("time_offset", randf_range(0.0, 5.0))
	pass

func _physics_process(delta):
	if(linear_velocity.length() < topSpeed):
		apply_central_force(global_transform.basis.x * accel * delta)

func _process(delta):
	timeOut -= delta
	if(timeOut <= 0):
		queue_free()


func _on_area_3d_body_entered(body):
	if(body.name != "Moria"):
		if(player != null):
				match body.name.rstrip("0123456789"):
					"Bookshelf":
						player.shotShelf = true
					"coral_s_":
						player.shotCoral = true
		queue_free()
