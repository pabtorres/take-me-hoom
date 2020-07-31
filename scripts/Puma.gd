extends Node2D

var dir="right"
var speed = 100
var velocity = Vector2.ZERO
var counter=0
var alive
var lifePoints
var time


# Called when the node enters the scene tree for the first time.
func _ready():
	time=0
	velocity = speed * (0.8*transform.x)
	alive=true;
	lifePoints=50;
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimationPlayer.play("Idle")
	position += velocity * delta
	counter+=1
	if (counter==100):
		if(dir=="right"):
			dir="left"
			velocity = speed * ((-1)*0.8*transform.x)
			$Sprite.flip_h=true
			$Area2D2/AttackLeft.disabled=!$Area2D2/AttackLeft.disabled
			$Area2D2/AttackRight.disabled=!$Area2D2/AttackRight.disabled
			counter=0
		elif (dir=="left"):
			dir="right"
			velocity = speed * (0.8*transform.x)
			$Sprite.flip_h=false
			$Area2D2/AttackLeft.disabled=!$Area2D2/AttackLeft.disabled
			$Area2D2/AttackRight.disabled=!$Area2D2/AttackRight.disabled
			counter=0

	 


func dead():
	queue_free()


func take_damage():
	if alive:
		lifePoints-=10;
		if lifePoints<=0:
			alive=false
			print("dead")
			$Area2D2/Attack.disabled=true
	print(lifePoints)


func _on_Area2D2_body_entered(body: Node):
	if body.is_in_group("Player"):
		body.take_damage(300)
