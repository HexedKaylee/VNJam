extends "res://Nodes/3D/pickup.gd"

@onready var UI = %UI
@onready var ray = $RayCast3D

var startGrab = false
var grabPlayed = false
var hasGrabbed = false
var chosen = false
var chosenName = ""
var thunk = preload("res://Assets/Audio/SFX/drop_book.ogg")
var sandThunk = preload("res://Assets/Audio/SFX/drop_book_sand.ogg")
var sand = false
var playSnd = true
var beingGrabbed = false

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
	elif(collider != null and hasGrabbed and snappedf(linear_velocity.y, 0.05) == 0):
		chosenName = collider.name.rstrip("0123456789")
		nextResult(chosenName)
	elif get_contact_count() <= 0:
		playSnd = true
		
func startResult(chosenName):
	print(chosenName)
	sand = false
	match(chosenName):
		"Terrain":
			UI.get_node("Controller").bookControl(1, "ex1_01a")
			startGrab = false
			grabPlayed = false
			hasGrabbed = false
			chosen = false
			chosenName = ""
			sand = true
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
	if !$AudioStreamPlayer3D.is_playing() and playSnd and !beingGrabbed:
		if sand:
			$AudioStreamPlayer3D.stream = sandThunk
		else:
			$AudioStreamPlayer3D.stream = thunk
		$AudioStreamPlayer3D.play()
		playSnd = false

func nextResult(chosenName):
	sand = false
	if(chosenName == "Terrain"):
		sand = true
	if !$AudioStreamPlayer3D.is_playing() and playSnd and !beingGrabbed:
		if sand:
			$AudioStreamPlayer3D.stream = sandThunk
		else:
			$AudioStreamPlayer3D.stream = thunk
		$AudioStreamPlayer3D.play()
		playSnd = false
