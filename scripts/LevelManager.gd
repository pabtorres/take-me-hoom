extends Node

var player_position_day = null
var player_position_night = null
var is_player_sleeping = false

var dark_zone = false

func turn_to_night():
	get_tree().change_scene("res://scenes/DesertNight.tscn")
	
func turn_to_day():
	get_tree().change_scene("res://scenes/Main.tscn")
