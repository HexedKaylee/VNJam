extends StaticBody3D

@export var col : Color

func _ready():
	var pillar = $greek_pillar/pillar_greek
	pillar.get_active_material(0).albedo_color = col
