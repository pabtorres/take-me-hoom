extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_NewGame_pressed():
	get_tree().change_scene("res://scenes/CinematicMenuDesert.tscn")

func _on_LoadGame_pressed():
	get_tree().change_scene("res://scenes/SavedGames.tscn")

func _on_Settings_pressed():
	get_tree().change_scene("res://scenes/Settings.tscn")

func _on_Credits_pressed():
	get_tree().change_scene("res://scenes/Credits.tscn")
