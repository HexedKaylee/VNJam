extends CharacterBody3D


@export var SPEED = 5.0
@export var sensivity = 0.3
@export var launch_height = -0.326
@export var rot_launch_targ = PI/8
@export var rot_launch_spd = 20.0
@export var rot_launch_orig = 0.0
@export var shot_cooldown = .5
var fov = false
var lerp_speed= 1
var has_launcher = false
@onready var launcher = $Camera/FishModel
@onready var launchPoint = $Camera/FishModel/LaunchPoint
var launch_rise = .05
var launchReady = false
var animStart = false
var fish = preload("res://Nodes/3D/Fish.tscn")
@export var SceneRoot : Node3D
var fishNum = 0
var shotShelf : bool
var shotCoral : bool
var serumsDrunk = 0
@onready var shaderPlane = $Camera/MeshInstance3D
@onready var UI = %UI
var shdCol : Color	
var shdColTarg = Color(255.0/255.0, 20.0/255.0, 93.0/255.0)
var redShift = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	shotShelf = false
	shotCoral = false

func _input(event):
	if event is InputEventMouseMotion:
		$Camera.rotation_degrees.x -= event.relative.y * sensivity
		$Camera.rotation_degrees.x = clamp($Camera.rotation_degrees.x, -90, 90)
		rotation_degrees.y -= event.relative.x * sensivity


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _process(delta):
	if has_launcher:
		control_launcher(delta)
		launcher.visible = true
	continualSerum(delta)

func control_launcher(delta):
	if(!launchReady):
		launcher.position.y = lerp(launcher.position.y, launch_height, launch_rise)
		if(snappedf(launcher.position.y, 0.05) == snappedf(launch_height, 0.05)):
			launchReady = true
	else:
		if Input.is_action_pressed("fire") and shot_cooldown <= 0.0:
			animStart = true
			shot_cooldown = 0.5
			var newFish = fish.instantiate()
			SceneRoot.add_child(newFish)
			newFish.global_transform.origin = launchPoint.global_transform.origin
			newFish.global_rotation = launcher.global_rotation
			newFish.linear_velocity = velocity
			newFish.player = self
			fishNum += 1
		if animStart:
			launcher.rotation.z = lerp(launcher.rotation.z, rot_launch_targ, rot_launch_spd*delta)
			if(snappedf(launcher.rotation.z, 0.05) == snappedf(rot_launch_targ, 0.05)):
				animStart = false
		else:
			launcher.rotation.z = lerp(launcher.rotation.z, rot_launch_orig, rot_launch_spd*delta)
		if shot_cooldown > 0.0:
			shot_cooldown -= delta

func applySerum(serum):
	serumsDrunk += 1
	match(serum):
		3:
			shdCol = shaderPlane.get_active_material(0).get_shader_parameter("tint")
			shaderPlane.get_active_material(0).set_shader_parameter("tint", shdCol)
			redShift = true
		6:
			UI.get_node("ImageOverlay").active = true
		_:
			print("ERROR: INVALID SERUM")

func continualSerum(delta):
	if(redShift):
		var shiftSpeed = 1.5
		shdCol = shaderPlane.get_active_material(0).get_shader_parameter("tint")
		shdCol.r = lerp(shdCol.r, shdColTarg.r, delta*shiftSpeed)
		shdCol.g = lerp(shdCol.g, shdColTarg.g, delta*shiftSpeed)
		shdCol.b = lerp(shdCol.b, shdColTarg.b, delta*shiftSpeed)
		shaderPlane.get_active_material(0).set_shader_parameter("tint", shdCol)
		
