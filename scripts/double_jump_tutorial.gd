extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Press_Space.visible = false
	$Press_Space2.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	$Press_Space.visible = true
	$Press_Space2.visible = true


func _on_Area2D_body_exited(body):
	$Press_Space.visible = false
	$Press_Space2.visible = false
