extends Node2D


# Declare member variables here. Examples:
# var b = "text"

var actual_scene = 1
var current_text_box = 1
var rich_group_text = "RichTextScene"
var ticks = 0
var ticks_to_show_character = 3
var chars_to_show = true
var max_text_boxes_per_scene = [2,1,1,1,1,1,1,1,1]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _physics_process(delta):
	if chars_to_show:
		if ticks >= ticks_to_show_character:
			ticks = 0
			var rich_text = get_tree().get_nodes_in_group(rich_group_text + str(actual_scene))[current_text_box-1]
			var lenght_of_rich_text = len(rich_text.get_text())
			var visible_characters = rich_text.get_visible_characters()
			if visible_characters < lenght_of_rich_text:
				rich_text.set_visible_characters(visible_characters+1)
			else:
				chars_to_show = false
				get_tree().get_nodes_in_group("ButtonScene" + str(actual_scene))[0].show()
		else:
			ticks += 1
	
	if Input.is_action_just_pressed("jump1"):
		ticks_to_show_character = 1
	
	if Input.is_action_just_released("jump1"):
		ticks_to_show_character = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Siguiente_pressed():
	if current_text_box == max_text_boxes_per_scene[actual_scene-1]:
		if actual_scene == 9:
			LevelManager.change_initial_cinematic_to_desert_cinematic()
		else:
			var scene = get_tree().get_nodes_in_group("Scene" + str(actual_scene))[0]
			actual_scene += 1
			var next_scene = get_tree().get_nodes_in_group("Scene" + str(actual_scene))[0]
			for element in scene.get_children():
				element.hide()
			for element in next_scene.get_children():
				if not element.is_in_group("ButtonScene" + str(actual_scene)):
					element.show()
			current_text_box = 1
			chars_to_show = true
	else:
		var text_nodes = get_tree().get_nodes_in_group(rich_group_text + str(current_text_box))
		text_nodes[current_text_box-1].hide()
		text_nodes[current_text_box].show()
		get_tree().get_nodes_in_group("ButtonScene" + str(actual_scene))[0].hide()
		current_text_box += 1
		chars_to_show = true
