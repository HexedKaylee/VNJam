extends StaticBody3D
 
@export var MyMesh:Node3D
var MyLights = []
var myColor : Color
@export var hMin = 180.0
@export var hMax = 320.0
@export var sMin = 60.0
@export var sMax = 75.0
@export var fullOdds = 25

# Called when the node enters the scene tree for the first time.
func _ready():
	var fullRange = randi_range(0, 99)
	var h = randf_range(hMin, hMax)
	if(fullRange < fullOdds):
		h = randf_range(0.0, 359.0)
	myColor = Color.from_hsv(h/360.0, randf_range(sMin, sMax)/100.0, 1.0)
	for child in get_children():
		var childName = child.name
		if child is OmniLight3D:
			MyLights.push_back(child)
			child.light_color = myColor
		if childName.to_lower().find("coral") != -1:
			var grandChild = child.get_node_or_null("Mesh")
			if(grandChild != null):
				grandChild.get_active_material(0).emission = myColor
