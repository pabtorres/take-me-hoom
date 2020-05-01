extends Area2D


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
	

func set_attack(value: bool):
	if alive==true:
		$Attack.disabled=!value


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if time!=100 && $AnimationPlayer.current_animation != "Attack" && $AnimationPlayer.current_animation != "Die":
		$AnimationPlayer.play("Idle")
		time+=1
	if time==100:
		$AnimationPlayer.play("Attack")
		time=0
	 
		
		
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="Die":
		dead()

func _on_Enemy_body_entered(body):
	#print(body.get_name())
	#print("hello")
	if alive:
		lifePoints-=10;
		if lifePoints<=0:
			alive=false
			print("dead")
			$AnimationPlayer.play("Die")
			#$Attack.disabled=true
			#$CollisionShape2D.disabled=true
			#$icon.visible = not $icon.visible
			
			
		
	print(lifePoints)
	#print(alive)
	#print(body)

func dead():
	$Attack.disabled=true
	$CollisionShape2D.disabled=true
	$icon.visible = not $icon.visible
