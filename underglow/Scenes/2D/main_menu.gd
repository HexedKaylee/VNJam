extends Control

@onready var startButton = $StartButton
@onready var continueButton = $ContinueButton
@onready var displayButton = $DisplayButton
@onready var quitButton = $QuitButton
var buttonArray = []
var active = false
var idx = 0
var icoUn = preload("res://Assets/UI/button_stable.png")
var icoSel = preload("res://Assets/UI/button_interact.png")

func _ready():
	buttonArray = [startButton, continueButton, displayButton, quitButton]

func _input(event):
	if event.is_action_pressed("mm_left"):
		active = true
	if event.is_action_pressed("mm_right"):
		active = true
	if event.is_action_pressed("mm_up"):
		if(active):
			idx -= 1
		active = true
	if event.is_action_pressed("mm_down"):
		if(active):
			idx += 1
		active = true
	if event.is_action_pressed("mm_select"):
		if(active):
			buttonArray[idx]._on_pressed()
		active = true
	if event.is_action_pressed("click"):
		false
	idx = wrapi(idx, 0, 4)

func _process(delta):
	if(active):
		for i in buttonArray.size():
			if(i != idx):
				buttonArray[i].set_button_icon(icoUn)
			else:
				buttonArray[i].set_button_icon(icoSel)
	else:
		for i in buttonArray.size():
			buttonArray[i].set_button_icon(icoUn)
