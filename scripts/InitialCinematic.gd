extends Node2D


# Declare member variables here. Examples:
# var b = "text"

var actual_scene = 1
var rich_group_text = "RichTextScene"
var ticks = 0
var ticks_to_show_character = 3
var chars_to_show = true

# Called when the node enters the scene tree for the first time.
func _ready():
	var rich_text = get_tree().get_nodes_in_group(rich_group_text + str(actual_scene))[0]
	print(rich_text.get_text())
	print(len(rich_text.get_text()))


func _physics_process(delta):
	if chars_to_show:
		if ticks >= ticks_to_show_character:
			ticks = 0
			var rich_text = get_tree().get_nodes_in_group(rich_group_text + str(actual_scene))[0]
			var lenght_of_rich_text = len(rich_text.get_text())
			var visible_characters = rich_text.get_visible_characters()
			if visible_characters < lenght_of_rich_text:
				rich_text.set_visible_characters(visible_characters+1)
			else:
				chars_to_show = false
		else:
			ticks += 1
	else:
		print("selfie")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
