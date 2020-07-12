extends Area2D

func _ready():
	connect("body_entered", self, "body_entered")

func body_entered(body):
	if body.get_name().begins_with("Player"):
		Global.keys["bus"]=true
		queue_free()
