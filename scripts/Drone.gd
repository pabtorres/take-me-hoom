extends Node2D

var dir="down"
var speed = 100
var velocity = Vector2.ZERO
var counter=0

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = speed * (0.8*transform.y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimationPlayer.play("Idle")
	position += velocity * delta
	counter+=1
	if(dir=="down"):
		if(counter==75):
			dir="up"
			velocity = speed * (-0.4*transform.y)
			counter=0
	if (dir=="up"):
		if(counter==150):
			dir="down"
			velocity = speed * (0.8*transform.y)
			counter=0
		
	
	
