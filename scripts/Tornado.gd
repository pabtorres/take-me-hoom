extends Area2D


# Movimiento del tornado
var speed = 130
var dir="left"
var velocity = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	if dir=="right":
		velocity = speed * (0.8*transform.x+0.2*transform.y)
	else:
		velocity = speed * (-0.8*transform.x+0.2*transform.y)
	
	

func _process(delta):
	$AnimationPlayer.play("Blow")
	position += velocity * delta
	





func _on_Tornado_body_entered(body):
	$Sprite.visible=false
