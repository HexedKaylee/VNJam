extends MeshInstance3D

var shelves = [preload("res://Assets/3D/Models/Bookshelves/bookshelf_2_001.obj"), preload("res://Assets/3D/Models/Bookshelves/bookshelf_2_002.obj"), preload("res://Assets/3D/Models/Bookshelves/bookshelf_2_003.obj"), preload("res://Assets/3D/Models/Bookshelves/bookshelf_2_004.obj")]

func _ready():
	var myShelf = shelves.pick_random()
	mesh = myShelf
