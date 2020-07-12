extends Area2D



# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "body_entered")

func body_entered(body):
	if body.get_name().begins_with("Player"):
		Global.keys["sewer"]=true
		print(Global.keys["sewer"])
		queue_free()
