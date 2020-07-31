extends Node2D

var actual_scene = 1
var ticks = 0
var ticks_to_show_character = 3
var chars_to_show = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _physics_process(delta):
	if chars_to_show:
		if ticks >= ticks_to_show_character:
			ticks = 0
			var rich_text = get_tree().get_nodes_in_group("CityText" + str(actual_scene))[0]
			var lenght_of_rich_text = len(rich_text.get_text())
			var visible_characters = rich_text.get_visible_characters()
			if visible_characters < lenght_of_rich_text:
				rich_text.set_visible_characters(visible_characters+1)
			else:
				chars_to_show = false
				get_tree().get_nodes_in_group("NextButtonCity" + str(actual_scene))[0].show()
		else:
			ticks += 1
	
	if Input.is_action_just_pressed("jump1"):
		ticks_to_show_character = 1
	
	if Input.is_action_just_released("jump1"):
		ticks_to_show_character = 3

func _on_Next_pressed():
	var scene = get_tree().get_nodes_in_group("Scene" + str(actual_scene))[0]
	actual_scene += 1
	var next_scene = get_tree().get_nodes_in_group("Scene" + str(actual_scene))[0]
	for element in scene.get_children():
		element.hide()
	for element in next_scene.get_children():
		if not element.is_in_group("NextButtonCity" + str(actual_scene)):
			element.show()
	chars_to_show = true

func _on_ToCity_pressed():
	LevelManager.change_level_to_city()
