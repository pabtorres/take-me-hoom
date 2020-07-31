extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Press_Left.visible = false
	$Press_Right.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	$Press_Left.visible = true
	$Press_Right.visible = true


func _on_Area2D_body_exited(body):
	$Press_Left.visible = false
	$Press_Right.visible = false
