extends Node2D


var dir="down"
var speed = 100
var velocity = Vector2.ZERO
var counter=0
var counterDeath=0

# Para definir los puntos de vida del enemigo 
var alive
var lifePoints



# Called when the node enters the scene tree for the first time.
func _ready():
	alive=true;
	lifePoints=50;
	velocity = speed * (0.8*transform.y)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (alive==true):
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
	else:
		$AnimationPlayer.play("Die")
		counterDeath+=1
		speed=0
		position += velocity * delta
		print(counterDeath)
		if (counterDeath==60):
			speed=500
			velocity = speed * (-0.8*transform.y)
	 
		
		

func take_damage():
	if alive:
		lifePoints-=10;
		if lifePoints<=0:
			alive=false
	print(lifePoints)


func _on_Area2D2_body_entered(body: Node):
	if body.is_in_group("Player"):
		body.take_damage()
