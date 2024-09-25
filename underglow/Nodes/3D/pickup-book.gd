extends "res://Nodes/3D/pickup.gd"

@onready var UI = %UI
@onready var ray = $RayCast3D

var startGrab = false
var grabPlayed = false
var hasGrabbed = false
var chosen = false
var chosenName = ""

func _process(delta):
	freezer()
	var collider = ray.get_collider()
	if(startGrab and !grabPlayed):
		UI.get_node("Controller").bookControl(0)
		grabPlayed = true
	if(collider != null and hasGrabbed and snappedf(linear_velocity.y, 0.05) == 0 and !chosen):
		chosenName = collider.name.rstrip("0123456789")
		chosen = true
		startResult(chosenName)
		
func startResult(chosenName):
	print(chosenName)
	match(chosenName):
		"Terrain":
			UI.get_node("Controller").bookControl(1, "ex1_01a")
			startGrab = false
			grabPlayed = false
			hasGrabbed = false
			chosen = false
			chosenName = ""
		"RedPillar":
			UI.get_node("Controller").bookControl(2, "ex1_02a")
		"BluePillar":
			UI.get_node("Controller").bookControl(2, "ex1_02b")
		"GreenPillar":
			UI.get_node("Controller").bookControl(2, "ex1_02c")
		"Bookshelf":
			UI.get_node("Controller").bookControl(2, "ex1_02d")
		"Campfire":
			UI.get_node("Controller").bookControl(3, "ex1_02e")
		"InitPillar":
			UI.get_node("Controller").bookControl(2, "ex1_02f")
		"GoldPillar":
			UI.get_node("Controller").bookControl(2, "ex1_02g")
		"Pillar":
			UI.get_node("Controller").bookControl(2, "ex1_02h")
		"CoralS ":
			UI.get_node("Controller").bookControl(2, "ex1_02i")
		_:
			UI.get_node("Controller").bookControl(1, "ex1_02j")
			
	#UI.get_node("TextBox").activate()
