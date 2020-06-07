extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Button_pressed():
	LevelManager.change_level_to_desert()
	LevelManager.reset_life_points()
