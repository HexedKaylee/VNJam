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
var fishTarg = 10
var hitShelf = false
var hitCoral = false
@export var SceneRoot : Node3D
var booksHeld = 0
var holdingBook = false
var bookTarg = 1
var serumTarg = 1
var serumsDrunk = 0
var drunkSeven = false

func _ready():
	diag = readJSON("res://Assets/Misc/ex_diag.json")
	diagDict = generateDict(diag)

func _process(delta):
	if(entry):
		fade.color.a = lerp(fade.color.a, 0.0, 0.5*fadeSpd*delta)
		if(snappedf(fade.color.a, 0.05) == 0):
			fade.color.a = 0
			entry = false
	elif !exit:
		match Experiment:
			1:
				exp1(delta)
			2:
				exp2(delta)
			3:
				exp3(delta)
			4:
				exp4(delta)
			_:
				pass
	else:
		fade.color.a = lerp(fade.color.a, 1.0, fadeSpd*delta)
		if(snappedf(fade.color.a, 0.05) == 1):
			fade.color.a = 1
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			match Experiment:
				1:
					Global.set_timeline("tl_04_college_tagging")
				2:
					Global.set_timeline("tl_07_prym_exp2")
				3:
					Global.set_timeline("tl_09_college_wandering")
				4:
					Global.set_timeline("tl_11_ending")
				_:
					pass
			Global.goto_scene("res://Scenes/2D/dialogic_scene.tscn")
		

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

func exp2(delta):
	launchControl()
	match scenePhase:
		0:
			scenePhase = 1
			textBox.activate(diagDict["ex2_00"])
		1:
			if(textBox.modulate.a == 0):
				timer += delta
				if(timer > waitMax):
					textBox.activate(diagDict["ex2_00a"])
					scenePhase = 2
					timer = 0
		2:
			if(textBox.modulate.a == 0):
				timer += delta
				if(timer > waitMax):
					textBox.activate(diagDict["ex2_00b"])
					scenePhase = 3
					timer = 0
		3:
			if(textBox.modulate.a == 0):
				timer += delta
				if(timer > waitMax):
					textBox.activate(diagDict["ex2_00c"])
					scenePhase = 4
					timer = 0
		6:
			if(textBox.modulate.a == 0):
				timer += delta
				if(timer > 1.0):
					exit = true
		_:
			pass

func exp3(delta):
	if player.serumsDrunk >= 8 and scenePhase < 5:
		scenePhase = 5
	match scenePhase:
		0:
			scenePhase = 1
			textBox.activate(diagDict["ex3_00"])
		1:
			if(textBox.modulate.a == 0):
				timer += delta
				if(timer > waitMax):
					textBox.activate(diagDict["ex3_00a"])
					scenePhase = 2
					timer = 0
		2:
			if(textBox.modulate.a == 0):
				timer += delta
				if(timer > waitMax):
					textBox.activate(diagDict["ex3_00b"])
					scenePhase = 3
					timer = 0
		3:
			if(textBox.modulate.a == 0):
				timer += delta
				if(timer > waitMax):
					textBox.activate(diagDict["ex3_00c"])
					scenePhase = 4
					timer = 0
		4:
			if(textBox.modulate.a == 0):
				timer += delta
				if(timer > waitMax):
					textBox.activate(diagDict["ex3_00d"])
					scenePhase = 5
					timer = 0
		5:
			if(textBox.modulate.a == 0 and player.serumsDrunk >= 8):
				scenePhase = 6
				textBox.activate(diagDict["ex3_02"])
		6:
			if(textBox.modulate.a == 0):
				timer += delta
				if(timer > 1.0):
					exit = true
		_:
			pass

func exp4(delta):
	bookCounter()
	ex4_tracker()
	match scenePhase:
		0:
			scenePhase = 1
			textBox.activate(diagDict["ex4_00"])
		1:
			if(textBox.modulate.a == 0):
				timer += delta
				if(timer > waitMax):
					textBox.activate(diagDict["ex4_00a"])
					scenePhase = 2
					timer = 0
		2:
			if(textBox.modulate.a == 0):
				timer += delta
				if(timer > waitMax):
					textBox.activate(diagDict["ex4_00b"])
					scenePhase = 3
					timer = 0
		3:
			if(textBox.modulate.a == 0):
				timer += delta
				if(timer > waitMax):
					textBox.activate(diagDict["ex4_00c"])
					scenePhase = 4
					timer = 0
		6:
			if(textBox.modulate.a == 0):
				timer += delta
				if(timer > waitMax):
					textBox.activate(diagDict["ex4_02a"])
					scenePhase = 7
					timer = 0
		7:
			if(textBox.modulate.a == 0):
				timer += delta
				if(timer > waitMax):
					textBox.activate(diagDict["ex4_02b"])
					scenePhase = 8
					timer = 0
		8:
			if(textBox.modulate.a == 0):
				timer += delta
				if(timer > waitMax):
					textBox.activate(diagDict["ex4_02c"])
					scenePhase = 9
					timer = 0
		12:
			if(textBox.modulate.a == 0):
				timer += delta
				if(timer > 1.0):
					exit = true
			
		13:
			if(textBox.modulate.a == 0):
				timer += delta
				if(timer > 1.0):
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

func launchControl():
	if(Experiment != 2 or scenePhase >= 6):
		return
	if(scenePhase < 5 and player.launchReady):
		scenePhase = 5
		timer = 0
		textBox.activate(diagDict["ex2_01"])
	if(scenePhase >= 5):
		if(!hitShelf and player.shotShelf):		
			textBox.activate(diagDict["ex2_02a"])
			hitShelf = true
		if(!hitCoral and player.shotCoral):		
			textBox.activate(diagDict["ex2_02b"])
			hitCoral = true
		if(textBox.modulate.a != 0):
			if(player.fishNum >= fishTarg):
				player.fishNum = fishTarg - 5
		elif(player.fishNum > fishTarg):
			match fishTarg:
				10:
					textBox.activate(diagDict["ex2_03a"])
				20:
					textBox.activate(diagDict["ex2_03b"])
				30:
					textBox.activate(diagDict["ex2_03c"])
				40:
					textBox.activate(diagDict["ex2_03d"])
				50:
					textBox.activate(diagDict["ex2_04"])
					scenePhase = 6
				_:
					print("ERROR: BAD FISH TARG!")
			timer = 0
			fishTarg += 10
			
func serumIngester(serum):
	if(Experiment != 3):
		serumsDrunk += 1
		if(serum == 7):
			drunkSeven = true
		return
	timer = 0
	print("ex3_01_" + str(serum))
	textBox.activate(diagDict["ex3_01_" + str(serum)])
	pass

func bookCounter():
	var grabber = player.get_node_or_null("Camera").get_node_or_null("RayCast3D")
	if(holdingBook and grabber.grabbed == null):
		holdingBook = false
	if(!holdingBook and grabber.grabbed != null):
		holdingBook = true
		booksHeld += 1

func ex4_tracker():
	if(scenePhase >= 6):
		distanceChecker()
		return
	if(textBox.modulate.a == 0):
		if(drunkSeven):
			scenePhase = 6
			textBox.activate(diagDict["ex4_02"])
			timer = 0
		else:
			if(holdingBook and booksHeld >= bookTarg):
				match bookTarg:
					1:
						scenePhase = 4
						textBox.activate(diagDict["ex4_01a"])
						bookTarg = 5
					5:
						textBox.activate(diagDict["ex4_01b"])
						bookTarg = 10
					10:
						textBox.activate(diagDict["ex4_01c"])
						bookTarg = INF
					_:
						pass
			elif(serumsDrunk >= serumTarg):
				match serumTarg:
					1:
						scenePhase = 4
						textBox.activate(diagDict["ex4_01d"])
						serumTarg = 3
					3:
						textBox.activate(diagDict["ex4_01e"])
						serumTarg = 5
					5:
						textBox.activate(diagDict["ex4_01f"])
						serumTarg = INF
					_:
						pass

func distanceChecker():
	if(textBox.modulate.a == 0):
		match(scenePhase):
			10:
				if(player.distance >= 60):
					scenePhase = 11
					textBox.activate(diagDict["ex4_03b"])
			11:
				if(player.distance >= 90):
					scenePhase = 12
					textBox.activate(diagDict["ex4_03c"])
			_:
				if(player.distance >= 30 and scenePhase < 10):
					scenePhase = 10
					textBox.activate(diagDict["ex4_03a"])

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
