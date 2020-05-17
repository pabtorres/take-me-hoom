extends Node

var player_position_day = null
var player_position_night = null
var is_player_sleeping = false

# Keys
var keys = 0

# Life Point
var life_points = 1000

# Controls if the zone has to be dark
var dark_zone = false

func exit_to_menu():
	get_tree().change_scene("res://scenes/Menu.tscn")
	MusicManager.change_menu_music()

func turn_to_night():
	get_tree().change_scene("res://scenes/DesertNight.tscn")
	MusicManager.change_desert_night_music()
	
func turn_to_day():
	get_tree().change_scene("res://scenes/DesertDay.tscn")
	MusicManager.change_desert_day_music()

func reset_life_points():
	life_points = 1000
