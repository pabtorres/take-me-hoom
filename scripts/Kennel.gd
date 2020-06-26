extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Kennel_area_entered(area):
	pass # Replace with function body.


func _on_Kennel_body_entered(body):
	if body.is_in_group("Player"):
		body.set_sleep_key(true)
		body.set_can_sleep(true)

func _on_Kennel_body_exited(body):
	if body.is_in_group("Player"):
		body.set_sleep_key(false)
		body.set_can_sleep(false)
