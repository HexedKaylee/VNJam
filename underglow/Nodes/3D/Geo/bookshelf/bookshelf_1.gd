extends MeshInstance3D

var shelves = [preload("res://Assets/3D/Models/Bookshelves/bookshelf_2_001.obj"), preload("res://Assets/3D/Models/Bookshelves/bookshelf_2_002.obj"), preload("res://Assets/3D/Models/Bookshelves/bookshelf_2_003.obj"), preload("res://Assets/3D/Models/Bookshelves/bookshelf_2_004.obj")]
var popEffect = preload("res://Nodes/3D/Effects/BubblePopOne.tscn")

func _ready():
	var myShelf = shelves.pick_random()
	mesh = myShelf

func _process(delta):
	if(Global.removeShelf_get()):
		var newPop = popEffect.instantiate()
		newPop.get_child(0).emitting = true
		get_parent().get_parent().add_child(newPop)
		newPop.global_transform.origin = global_transform.origin
		get_parent().queue_free()
