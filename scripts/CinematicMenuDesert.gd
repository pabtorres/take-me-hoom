extends Node2D

var ticks = 0
var ticks_to_show_character = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	if ticks >= ticks_to_show_character:
		ticks = 0
		var rich_text = get_tree().get_nodes_in_group("RichTextBeforeAdventure")[0]
		var lenght_of_rich_text = len(rich_text.get_text())
		var visible_characters = rich_text.get_visible_characters()
		if visible_characters < lenght_of_rich_text:
			rich_text.set_visible_characters(visible_characters+1)
		else:
			get_tree().get_nodes_in_group("ButtonToGame")[0].show()
	else:
		ticks += 1

func _on_Button_pressed():
	LevelManager.change_level_to_desert()
	LevelManager.reset_life_points()
