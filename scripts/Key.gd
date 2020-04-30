extends Area2D

func _ready():
	connect("body_entered", self, "body_entered")

func body_entered(body):
	if body.get_name().begins_with("Player"):
		LevelManager.keys += 1
		queue_free()
