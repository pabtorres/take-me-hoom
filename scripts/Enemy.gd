extends Node2D


# Para que ataque cada 100 frames
var time

# Para definir los puntos de vida del enemigo 
var alive
var lifePoints


# Called when the node enters the scene tree for the first time.
func _ready():
	time=0
	alive=true;
	lifePoints=50;
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if alive:
		if time!=100 && $AnimationPlayer.current_animation != "Attack" && $AnimationPlayer.current_animation != "Die":
			$AnimationPlayer.play("Idle")
			time+=1
		if time==100:
			$AnimationPlayer.play("Attack")
			time=0
	 
		
		
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="Die":
		dead()



func dead():
	queue_free()







func take_damage():
	if alive:
		lifePoints-=10;
		if lifePoints<=0:
			alive=false
			$AnimationPlayer.play("Die")
			$Area2D2/Attack.disabled=true


func _on_Area2D2_body_entered(body: Node):
	if body.is_in_group("Player"):
		body.take_damage(50)
