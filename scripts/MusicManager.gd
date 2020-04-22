extends AudioStreamPlayer2D

const tracks = [
  'music_test.wav',
  'music_test.wav',
]

var can_change_music = false

func _ready():
	 # var rand_nb = Randi() % tracks.size()
	 var audiostream = load("res://music/" + tracks[0])
	 set_stream(audiostream)
	 play()
	 pass
	
func _process(delta):
	if (LevelManager.is_player_sleeping and can_change_music):
		var audiostream = load("res://music/" + tracks[1])
		set_stream(audiostream)
		play()
		can_change_music = false
		pass
	elif(!LevelManager.is_player_sleeping and can_change_music):
		var audiostream = load("res://music/" + tracks[0])
		set_stream(audiostream)
		play()
		can_change_music = false
		pass
