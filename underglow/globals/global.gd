extends Node

var timeline = 'tl_00_prologue_intro'

var save_path = "user://data.save"
var saveScene = "res://Scenes/2D/dialogic_scene.tscn"
var saveLine = 'tl_00_prologue_intro'

var current_scene = null
var destroyShelf = false

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func set_timeline(tl):
	timeline = tl
	
func get_timeline():
	return timeline

func removeShelf_set():
	destroyShelf = true
	
func removeShelf_get():
	return destroyShelf
	
func saveData(path):
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	saveScene = path
	file.store_var(saveScene)
	saveLine = timeline
	file.store_var(saveLine)

func loadData():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		saveScene = file.get_var()
		saveLine = file.get_var()
	timeline = saveLine
	goto_scene(saveScene)

func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	destroyShelf = false
	Global.saveData(path)
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# It is now safe to remove the current scene.
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instantiate()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
