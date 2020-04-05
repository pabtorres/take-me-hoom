extends Node

export(String, FILE, "*.tscn") var world_scene

var day_pos = null
var is_day = true
var day_pos_2 = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	yield(get_tree().create_timer(5),"timeout")
#	get_tree().change_scene(world_scene)
	
func change_level():
	#if (get_tree().get_current_scene().get_name() == "Main"):
	get_tree().change_scene("res://scenes/NightWorld1.tscn")
	#else:
	#	get_tree().change_scene("res://scenes/Main.tscn")
	
func change_level_2():
	#if (get_tree().get_current_scene().get_name() == "Main"):
	get_tree().change_scene("res://scenes/Main.tscn")
	#else:
	#	get_tree().change_scene("res://scenes/Main.tscn")
