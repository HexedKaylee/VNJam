extends Node

func init_audio():
	Dialogic.Audio.base_music_player.bus = "Dialogic_Music"
	Dialogic.Audio.base_music_player.process_mode = Node.PROCESS_MODE_ALWAYS
	Dialogic.Audio.base_sound_player.bus = "Dialogic_SFX"
	
func get_audio_stream_length():
	print(Dialogic.Audio.current_music_player.stream.get_length())
	
func fade_music_quiet(fade_time: float):
	var fader: Tween = null
	fader = create_tween()
	fader.tween_property(Dialogic.Audio.current_music_player, "volume_db", -15.0, fade_time)
	
func fade_music_silent(fade_time: float):
	var fader: Tween = null
	fader = create_tween()
	fader.tween_property(Dialogic.Audio.current_music_player, "volume_db", -80.0, fade_time)
	
	
func fade_music_normal(fade_time: float):
	var fader: Tween = null
	fader = create_tween()
	fader.tween_property(Dialogic.Audio.current_music_player, "volume_db", 0.0, fade_time)
	
	
