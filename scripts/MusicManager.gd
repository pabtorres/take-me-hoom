extends AudioStreamPlayer

const tracks = [
  'menu.ogg',
  'music_test.wav',
  'PRDS01_DIA.ogg',
  'PRDS01_NOCHE.ogg',
]

var can_change_music = false

func _ready():
	 var audiostream = load("res://music/" + tracks[0])
	 set_stream(audiostream)
	 play()
	
func _process(delta):
	pass

func change_desert_day_music():
	var audiostream = load("res://music/" + tracks[2])
	set_stream(audiostream)
	play()

func change_menu_music():
	var audiostream = load("res://music/" + tracks[0])
	set_stream(audiostream)
	play()

func change_desert_night_music():
	var audiostream = load("res://music/" + tracks[3])
	set_stream(audiostream)
	play()

func pause_music(pause):
	set_stream_paused(pause)
