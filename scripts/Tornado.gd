extends Area2D


# Movimiento del tornado
var speed = 130
var dir="left"
var velocity = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	if dir=="left":
		velocity = speed * (0.8*transform.x+0.2*transform.y)
	else:
		velocity = speed * (-0.8*transform.x+0.2*transform.y)
	
	

func _process(delta):
	$AnimationPlayer.play("Blow")
	position += velocity * delta
	


func take_damage():
	queue_free()


func _on_Tornado_body_entered(body: Node):
	queue_free()
	if body.is_in_group("Player"):
		body.take_damage(50)
		body.velocity += (body.global_position - global_position).normalized() * 500
