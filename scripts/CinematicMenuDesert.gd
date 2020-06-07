extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Button_pressed():
	#LevelManager.turn_to_day()
	#get_tree().change_scene("res://scenes/DesertDay.tscn")
	#MusicManager.change_desert_day_music()
	LevelManager.change_level_to_desert()
	#MusicManager.change_music(1)
	LevelManager.reset_life_points()
