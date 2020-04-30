extends Area2D

var dir="left"

var destroyed = false
var speed = 130

var velocity = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	if dir=="right":
		velocity = speed * (0.8*transform.x+0.2*transform.y)
	else:
		velocity = speed * (-0.8*transform.x+0.2*transform.y)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimationPlayer.play("Blow")
	position += velocity * delta
	





func _on_Tornado_body_entered(body):
	$Sprite.visible=false
