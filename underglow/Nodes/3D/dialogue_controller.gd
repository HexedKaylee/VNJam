extends Control

@export var Experiment = 1
@export var BooksToSpawn = 15
@onready var textBox = %TextBox
@onready var fade = $ColorRect
@export var player : Node3D
var entry = true
var exit = false
var fadeSpd = 4
var diag
var diagDict = {}
var scenePhase = 0
var timer = 0.0
var waitMax = 15.0
var book = preload("res://Nodes/3D/pickup.tscn")
@export var SceneRoot : Node3D

func _ready():
	diag = readJSON("res://Assets/Misc/ex_diag.json")
	diagDict = generateDict(diag)

func _process(delta):
	if(entry):
		fade.color.a = lerp(fade.color.a, 0.0, fadeSpd*delta)
		if(snappedf(fade.color.a, 0.05) == 0):
			fade.color.a = 0
			entry = false
	elif !exit:
		match Experiment:
			1:
				exp1(delta)
			_:
				pass
	else:
		fade.color.a = lerp(fade.color.a, 1.0, fadeSpd*delta)
		if(snappedf(fade.color.a, 0.05) == 1):
			fade.color.a = 1
			#Move to other scene here
		

func exp1(delta):
	match scenePhase:
		0:
			scenePhase = 1
			textBox.activate(diagDict["ex1_00"])
		1:
			if(textBox.modulate.a == 0):
				timer += delta
				if(timer > waitMax):
					textBox.activate(diagDict["ex1_00a"])
					scenePhase = 2
					timer = 0
		2:
			if(textBox.modulate.a == 0):
				timer += delta
				if(timer > waitMax):
					textBox.activate(diagDict["ex1_00b"])
					scenePhase = 3
					timer = 0
		3:
			if(textBox.modulate.a == 0):
				timer += delta
				if(timer > waitMax):
					textBox.activate(diagDict["ex1_00c"])
					scenePhase = 4
					timer = 0
					
		7:
			if(textBox.modulate.a == 0):
				exit = true
				
		8:
			if(textBox.line.length() == textBox.stringPos):
				for i in BooksToSpawn:
					var newBook = book.instantiate()
					SceneRoot.add_child(newBook)
					newBook.global_transform.origin = player.global_transform.origin
					newBook.global_transform.origin.y += 5.0 + randf_range(-1, 1)
					newBook.global_transform.origin.x += randf_range(-2, 2)
					newBook.global_transform.origin.z += randf_range(-2, 2)
					newBook.player = player
				scenePhase = 9
		9:
			if(textBox.modulate.a == 0):
				exit = true
		_:
			pass
			
func bookControl(action, scn = ""):
	if Experiment != 1:
		return
	match action:
		0:
			if(scenePhase < 5):
				scenePhase = 5
				timer = 0
				textBox.activate(diagDict["ex1_01"])
		1:
			if(scenePhase < 6):
				scenePhase = 6
				timer = 0
				textBox.activate(diagDict[scn])
		2:
			if(scenePhase < 7):
				scenePhase = 7
				timer = 0
				textBox.activate(diagDict[scn])
		3:
			if(scenePhase < 7):
				scenePhase = 8
				timer = 0
				textBox.activate(diagDict[scn])
		_:
			pass

func readJSON(json_file_path):
	var file = FileAccess.open(json_file_path, FileAccess.READ)
	var content = file.get_as_text()
	var json = JSON.new()
	var finish = json.parse_string(content)
	return finish

func generateDict(js):
	var d = {}
	for line in diag:
		d[line["id"]] = line["line"]
	return d
