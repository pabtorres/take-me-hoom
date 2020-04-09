extends KinematicBody2D
var direction='left'

# Fricción
var hfriction = 60

# Restricciones de velocidad
var max_hspeed = 350
var max_uspeed = 600
var max_dspeed = 480
var max_gravity = 1000

# Para poder tacklear
var tackle = false
var tackle_friction = 120

# Para poder lanzar proyectiles
var bullet = true
var bullet_cooldown = 0.25
var bullet_cooldown_counter = 0

# Referencia gravedad
export var gravity = 0
export var velocity = Vector2.ZERO

# Método creado para multiplicar por -1
func reverse(val):
	return -val

func set_attack(value: bool):
	$Attack.disabled=!value
	$Attack/Sprite.visible=not $Attack/Sprite.visible
	
	
func _physics_process(delta):

	velocity.y += gravity * delta
	move_and_slide(velocity, Vector2.UP, true)
	
	if !tackle:
	
		var hsign = sign(velocity.x)
		velocity.x -= hsign * hfriction
		if sign(velocity.x) != hsign:
			velocity.x = 0
			
		if Input.is_action_pressed("jump1") && gravity == 0:
			velocity.y = -max_uspeed
			gravity = max_gravity
			$AnimationPlayer.play("Jump")
			
		# Se añade una consulta para saber si se está activada la animación de ladrido
		if Input.is_action_pressed("left1") && !Input.is_action_pressed("right1") && $AnimationPlayer.current_animation != "Bark":
			velocity.x = -max_hspeed
			if direction=="right":
				$Attack/Sprite.position.x-=20
				$Attack.position.x *=-1
				$Attack/Sprite.flip_h=false
				direction="left"
			$AnimationPlayer.play("Run")
			get_node( "Sprite" ).set_flip_h( false )
			
		
				
		# Se añade una consulta para saber si se está activada la animación de ladrido
		if Input.is_action_pressed("right1") && !Input.is_action_pressed("left1") && $AnimationPlayer.current_animation != "Bark":
			velocity.x = max_hspeed
			if direction=="left":
				$Attack.position.x *=-1
				$Attack/Sprite.flip_h=true
				$Attack/Sprite.position.x+=20
				direction="right"
			$AnimationPlayer.play("Run")
			get_node( "Sprite" ).set_flip_h( true )
			
		
	
			
		if is_on_floor() && velocity.y > 0 && abs(velocity.x) == 0 :
			# Se añade una consulta para saber si se está activada la animación de ladrido
			# Si no está activada esa animación, entonces puede pasar a animar idle
			if !Input.is_action_pressed("attack1") && $AnimationPlayer.current_animation != "Bark":
				$AnimationPlayer.play("Idle")
			else: 
				$AnimationPlayer.play("Bark")
			
			
			
			
			
			gravity = 0
			velocity.y = 0
		else:
			gravity = max_gravity
	
		velocity.y = min(velocity.y, max_dspeed)
		
