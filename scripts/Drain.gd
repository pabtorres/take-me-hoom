extends KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.





func _on_Area2D_body_entered(body):
	print(Global.keys["sewer"])
	if Global.keys["sewer"]==true:
		queue_free()
