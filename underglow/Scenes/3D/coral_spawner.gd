extends Node3D

var corals = 1000
var radiusMin = 50.0
var radiusMax = 250.0
var coralObjects = [preload("res://Nodes/3D/Geo/coral/coral_s_01.tscn"), preload("res://Nodes/3D/Geo/coral/coral_s_02.tscn"), preload("res://Nodes/3D/Geo/coral/coral_s_03.tscn"), preload("res://Nodes/3D/Geo/coral/coral_s_04.tscn"), preload("res://Nodes/3D/Geo/coral/coral_s_07.tscn"), preload("res://Nodes/3D/Geo/coral/coral_s_08.tscn"), preload("res://Nodes/3D/Geo/coral/coral_s_09.tscn"), preload("res://Nodes/3D/Geo/coral/coral_s_10.tscn"), preload("res://Nodes/3D/Geo/coral/coral_s_11.tscn"), preload("res://Nodes/3D/Geo/coral/coral_s_12.tscn"), preload("res://Nodes/3D/Geo/coral/coral_s_13.tscn"), preload("res://Nodes/3D/Geo/coral/coral_s_14.tscn")]

#func _ready():
#	var player = get_node_or_null("Moria")
#	for coral in corals:
#		var newCoral = coralObjects.pick_random().instantiate()
#		newCoral.global_transform = player.global_transform
#		add_child(newCoral)
#		var myRadius = randf_range(radiusMin, radiusMax)
#		var ang = randf_range(0.0, 2.0*PI)
#		newCoral.global_transform.origin.x += cos(ang)*myRadius
#		newCoral.global_transform.origin.z += sin(ang)*myRadius
#		newCoral.global_transform.origin.y = Heightmap.get_height(newCoral.global_transform.origin.x,newCoral.global_transform.origin.z)
#		newCoral.scale *= 3.0
#		newCoral.get_node_or_null("CollisionShape3D").queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
