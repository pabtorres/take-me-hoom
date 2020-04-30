extends Area2D

var time=0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if time==100:
		if $Sprite.flip_h==false:
			$Sprite.flip_h=true
		else:
			$Sprite.flip_h=false
		time=0
	time+=1
	$AnimationPlayer.play("Idle")

