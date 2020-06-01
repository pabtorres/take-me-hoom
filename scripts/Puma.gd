extends Area2D

var dir="right"
var speed = 100
var velocity = Vector2.ZERO
var counter=0
var alive
var lifePoints

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = speed * (0.8*transform.x)
	alive=true;
	lifePoints=50;
	

	

func _process(delta):
	$AnimationPlayer.play("Idle")
	position += velocity * delta
	counter+=1
	if (counter==100):
		if(dir=="right"):
			dir="left"
			velocity = speed * ((-1)*0.8*transform.x)
			$Sprite.flip_h=true
			counter=0
		elif (dir=="left"):
			dir="right"
			velocity = speed * (0.8*transform.x)
			$Sprite.flip_h=false
			counter=0


func _on_Puma_area_entered(area):
	if alive:
		lifePoints-=10;
		if lifePoints<=0:
			alive=false
			print("dead")
			$CollisionShape2D.disabled=true
			$Sprite.visible = not $Sprite.visible
	print(lifePoints)
