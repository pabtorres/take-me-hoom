extends Node2D

var is_paused = false
var can_press_esc = true

# Called when the node enters the scene tree for the first time.
func _ready():
	hide_menu(true)
	var settings_buttons = get_tree().get_nodes_in_group("InGameSettings")
	for button in settings_buttons:
		button.set_pressed(Global.settings[button.get_name()])

func hide_menu(value: bool):
	$InGameMenuLayer/InGameMenuBackground.visible = !value
	$InGameMenuLayer/InGameMenuContainer.visible = !value
	

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if is_paused:
			if can_press_esc:
				get_tree().paused = false
				hide_menu(true)
				check_settings()
				is_paused = !is_paused
		else:
			get_tree().paused = true
			hide_menu(false)
			is_paused = !is_paused

func check_settings():
	MusicManager.pause_music(!Global.settings["Music"])

#In Game Menu Panel
func _on_Continue_pressed():
	get_tree().paused = false
	check_settings()
	hide_menu(true)

func _on_Settings_pressed():
	$InGameMenuLayer/InGameMenuContainer.visible = false
	$InGameMenuLayer/SettingsPanel.visible = true
	can_press_esc = false

func _on_RetryLevel_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false
	LevelManager.reset_life_points()
	check_settings()

func _on_ExitMainMenu_pressed():
	$InGameMenuLayer/InGameMenuContainer.visible = false
	$InGameMenuLayer/MenuConfirmationPanel.visible = true
	can_press_esc = false

func _on_ExitGame_pressed():
	$InGameMenuLayer/InGameMenuContainer.visible = false
	$InGameMenuLayer/ExitConfirmationPanel.visible = true
	can_press_esc = false

#Settings Panel
func _on_Music_pressed():
	Global.settings["Music"] = !Global.settings["Music"]

func _on_SoundEffects_pressed():
	Global.settings["SoundEffects"] = !Global.settings["SoundEffects"]

func _on_BackToMenu_pressed():
	$InGameMenuLayer/SettingsPanel.visible = false
	$InGameMenuLayer/InGameMenuContainer.visible = true
	can_press_esc = true

#Back to Main Menu Panel
func _on_NoMenu_pressed():
	$InGameMenuLayer/MenuConfirmationPanel.visible = false
	$InGameMenuLayer/InGameMenuContainer.visible = true
	can_press_esc = true

func _on_YesMenu_pressed():
	get_tree().paused = false
	can_press_esc = true
	check_settings()
	LevelManager.exit_to_menu()

#Quit Game Panel
func _on_NoExit_pressed():
	$InGameMenuLayer/ExitConfirmationPanel.visible = false
	$InGameMenuLayer/InGameMenuContainer.visible = true
	can_press_esc = true

func _on_YesExit_pressed():
	get_tree().quit()
