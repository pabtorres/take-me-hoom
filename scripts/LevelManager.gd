extends Node

var player_position_day = null
var player_position_night = null
var is_player_sleeping = false

export var enemy_must_be_instantiated=false

# Keys
var keys = 0

# Life Point
var life_points = 1000

# Controls if the zone has to be dark
var dark_zone = false

# 0 = desert day, 1 = desert night, 2 = city day, 3 = city night, etc...
var current_level = 0

# List with all the
var spawn_positions = [Vector2(2080.6, 158.9), Vector2(39.06, 105)]

func exit_to_menu():
	get_tree().change_scene("res://scenes/Menu.tscn")
	MusicManager.change_menu_music()

func turn_to_night():
	get_tree().change_scene("res://scenes/DesertNight.tscn")
	current_level = 1
	MusicManager.change_desert_night_music()
	
func turn_to_day():
	get_tree().change_scene("res://scenes/DesertDay.tscn")
	current_level = 0
	MusicManager.change_desert_day_music()

func reset_life_points():
	life_points = 1000

func level_spawn_position():
	return spawn_positions[current_level]
