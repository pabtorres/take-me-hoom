extends Node2D


# Declare member variables here. Examples:
# var a = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	var buttons = get_tree().get_nodes_in_group("SettingsButtons")
	for button in buttons:
		button.set_pressed(Global.settings[button.get_name()])


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Music_pressed():
	Global.settings["Music"] = !Global.settings["Music"]
	print(Global.settings["Music"])

func _on_SoundEffects_pressed():
	Global.settings["SoundEffects"] = !Global.settings["SoundEffects"]
	print(Global.settings["SoundEffects"])

func _on_BackToMenu_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")
