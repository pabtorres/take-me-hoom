extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var buttons = get_tree().get_nodes_in_group("SettingsButtons")
	for button in buttons:
		button.set_pressed(Global.settings[button.get_name()])

func _on_Music_pressed():
	Global.settings["Music"] = !Global.settings["Music"]
	MusicManager.pause_music(!Global.settings["Music"])

func _on_SoundEffects_pressed():
	Global.settings["SoundEffects"] = !Global.settings["SoundEffects"]

func _on_BackToMenu_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")
