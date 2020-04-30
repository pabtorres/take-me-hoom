extends Area2D

var time=0
var velocity
const bullet_obj = preload("res://scenes/Tornado.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if time==100:
		if $Sprite.flip_h==false:
			$Sprite.flip_h=true
			var bullet_inst = bullet_obj.instance()
			bullet_inst.dir="right"
			bullet_inst.position.x=0
			bullet_inst.position.y=-10
			bullet_inst.rotation = rotation
			$Bullets.add_child(bullet_inst)
			
		else:
			$Sprite.flip_h=false
			var bullet_inst = bullet_obj.instance()
			bullet_inst.dir="left"
			bullet_inst.position.x=0
			bullet_inst.position.y=-10
			velocity=bullet_inst.speed * (0.8*transform.x+0.2*transform.y)
			velocity*=-1
			bullet_inst.velocity=velocity
			bullet_inst.rotation = rotation
			$Bullets.add_child(bullet_inst)
		time=0
	time+=1
	
	$AnimationPlayer.play("Idle")

