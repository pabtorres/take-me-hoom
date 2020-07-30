extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	MusicManager.pause_music(true)

func _on_Exit_pressed():
	LevelManager.exit_to_menu()
	MusicManager.pause_music(false)

func _on_Retry_pressed():
	LevelManager.player_death()
	MusicManager.pause_music(false)
