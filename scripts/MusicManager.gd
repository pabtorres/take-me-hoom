extends AudioStreamPlayer

const tracks = [
  'menu.ogg',
  'PRDS01_DIA.ogg',
  'PRDS01_NOCHE.ogg',
  'PRDS02_DIA.ogg',
  'PRDS02_NOCHE.ogg',
  'PRDS03_ENDING.ogg',
]

var can_change_music = false

func _ready():
	 set_volume_db(-7.0)
	 var audiostream = load("res://music/" + tracks[0])
	 set_stream(audiostream)
	 play()
	
func _process(delta):
	pass

func change_music(level_id: int):
	var audiostream = load("res://music/" + tracks[level_id])
	set_stream(audiostream)
	play()

func pause_music(pause):
	set_stream_paused(pause)
