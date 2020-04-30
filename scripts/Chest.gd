extends Area2D

var open_chest_tex = preload("res://sprites/keyitems/chest_opened.png")
onready var chest_sprite = get_node("ChestSprite")

func _ready():
	connect("body_entered", self, "body_entered")

func body_entered(body):
	if body.get_name().begins_with("Player"):
		if (LevelManager.keys>0):
			# https://godotengine.org/qa/16683/answered-how-to-change-the-texture-of-a-sprite
			LevelManager.keys -= 1
			chest_sprite.set_texture(open_chest_tex)
