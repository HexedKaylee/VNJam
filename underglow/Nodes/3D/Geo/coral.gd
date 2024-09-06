extends StaticBody3D
 
@export var MyMesh:Node3D
var MyLights = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is OmniLight3D:
			MyLights.push_back(child)
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
