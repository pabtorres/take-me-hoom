extends Node2D

var dir="down"
var speed = 100
var velocity = Vector2.ZERO
var counter=0
var counterDeath=0

# Para definir los puntos de vida del enemigo 
var alive
var lifePoints


func _ready():
	velocity = speed * (0.8*transform.y)
	alive=true;
	lifePoints=50;


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
		$AnimationPlayer.play("die")
		counterDeath+=1
		position += velocity * delta
		
		if (counterDeath==30):
			speed=500
			velocity = speed * (-0.8*transform.y)
			
		
	
	
func _on_Drone_body_entered(body):
	if alive:
		lifePoints-=10;
		if lifePoints<=0:
			alive=false
			speed=0
			velocity = speed * (0 *transform.y)
			print("dead")
			
	
