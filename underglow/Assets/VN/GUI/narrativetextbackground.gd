extends Node

@export var fade_speed: float
var invisible_color = Color(1, 1, 1, 0)
var transparent_color = Color(1, 1, 1, 0.494)
var opaque_color = Color.WHITE

func _ready():
	self.modulate = invisible_color
	Dialogic.Text.animation_textbox_show.connect(_on_animation_textbox_show)
	Dialogic.Text.animation_textbox_hide.connect(_on_animation_textbox_hide)
	
	
func _on_animation_textbox_show():
		self.modulate = invisible_color
		if(get_tree() != null):
			var tween = get_tree().create_tween()
			tween.tween_property(self, "modulate", transparent_color, 0.5)
	
func _on_animation_textbox_hide():
	if(self.modulate != invisible_color && get_tree() != null):
			var tween = get_tree().create_tween()
			tween.tween_property(self, "modulate", invisible_color, 0.5)
