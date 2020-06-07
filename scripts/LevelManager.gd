extends Node

var player_position_day = null
var player_position_night = null
var is_player_sleeping = false

export var enemy_must_be_instantiated=false

# Keys
var keys = 0

# Life Point
var max_life_points = 1000
var life_points = 1000

# Controls if the zone has to be dark
var dark_zone = false

# 0 = main menu, 1 = desert day, 2 = desert night, 3 = city day, 4 = city night, etc...
var current_level = 0

# 0 = desert, 1 = city, 2 = south/forest
var level_dict_scenes = {0: "res://scenes/Menu.tscn", 1: "res://scenes/DesertDay.tscn",
	2: "res://scenes/DesertNight.tscn", 3: "res://scenes/CityDay.tscn",
	4: "res://scenes/CityNight.tscn", 5: "res://scenes/SouthDay.tscn",
	6: "res://scenes/SouthNight.tscn"}

# List with all the
var spawn_positions = [Vector2(-300, 50), Vector2(39.06, 105), Vector2(-534, -43), Vector2(0, 0)]

func _ready():
	MusicManager.change_music(current_level)

func exit_to_menu():
	current_level = 0
	get_tree().change_scene(level_dict_scenes[current_level])
	reset_spawn_positions()
	MusicManager.change_music(current_level)

func turn_to_night():
	current_level += 1
	get_tree().change_scene(level_dict_scenes[current_level])
	MusicManager.change_music(current_level)
	
func turn_to_day():
	current_level -= 1
	get_tree().change_scene(level_dict_scenes[current_level])
	MusicManager.change_music(current_level)

func change_level_to_desert():
	current_level = 1
	reset_player_positions()
	get_tree().change_scene(level_dict_scenes[current_level])
	MusicManager.change_music(current_level)

func change_level_to_city():
	current_level = 3
	reset_player_positions()
	get_tree().change_scene(level_dict_scenes[current_level])
	MusicManager.change_music(current_level)

func reset_life_points():
	life_points = max_life_points

func level_spawn_position():
	return spawn_positions[current_level-1]

func get_max_life_points():
	return max_life_points

func set_max_life_points(new_max: int):
	max_life_points = new_max

func reset_player_positions():
	player_position_day = null
	player_position_night = null

func reset_spawn_positions():
	spawn_positions = [Vector2(-300, 50), Vector2(39.06, 105), Vector2(-534, -43), Vector2(0, 0)]

func override_spawn_position(checkpoint: Vector2):
	spawn_positions[current_level-1] = checkpoint
